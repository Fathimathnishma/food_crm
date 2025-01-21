import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class OrderSummeryProvider extends ChangeNotifier {
  final IOrderSummeryFacade iOrderSummeryFacade;
  OrderSummeryProvider(this.iOrderSummeryFacade);

  List<ItemAddingModel> itemsList = [];
  bool isLoading = false;
  num overallTotal = 0;
 bool isValid=true;

  void addItemToSummery(List<ItemAddingModel> items) {
    overallTotal = 0;

    for (var item in items) {
      final num price = num.parse(item.price.text);
      final num itemQty = num.parse(item.quantity.text);
      final num itemTotal = price * itemQty;
      overallTotal += itemTotal;
    }
    itemsList=items;

    notifyListeners();
  }

  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();

    final result = await iOrderSummeryFacade.fetchUsers();
    result.fold(
      (l) {
        log("Error fetching users: ${l.toString()}");
      },
      (userList) {
        for (var item in itemsList) {
          // Add users to the item first
          item.users.addAll(
            userList.map(
              (user) {
                return UserItemQtyAloccatedModel(
                  name: user.name,
                  phoneNumber: user.phoneNumber,
                  qty: TextEditingController(),
                  id: user.id!,
                  splitAmount: 0,
                  
                );
              },
            ).toList(),
          );
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void removeUserFromSummery({
    required int tabIndex,
    required int userIndex,
    required String price,
  }) {
    itemsList[tabIndex].users.removeAt(userIndex);
    if (itemsList[tabIndex].users.isNotEmpty) {
      initiolSplitQty(tabIndex: tabIndex, userIndex: userIndex, price: price);
      updateSplitAmount(tabIndex: tabIndex, userIndex: userIndex, price: price);
    }
    notifyListeners();
  }

  void updateSplitAmount({
    required int tabIndex,
    required int userIndex,
    required String price,
  }) {
    final user = itemsList[tabIndex].users[userIndex];
    final num qty = num.tryParse(user.qty.text) ?? 0;

    final double itemPrice = double.tryParse(price) ?? 0.0;
    user.splitAmount = itemPrice * qty;
  }

  void initiolSplitQty({
  required int tabIndex,
  required int userIndex,
  required String price,
}) {
  final num totalQty = num.tryParse(itemsList[tabIndex].quantity.text) ?? 0;
  final users = itemsList[tabIndex].users;

  if (users.isNotEmpty) {
    final num qtyPerUser = totalQty / users.length;

    for (var user in users) {
      String formattedQty;
      if (qtyPerUser == qtyPerUser.toInt()) {
        formattedQty = qtyPerUser.toInt().toString(); 
      } else {
        formattedQty = qtyPerUser.toStringAsFixed(1); 
      }

      user.qty.text = formattedQty;
      num userQty = num.tryParse(formattedQty) ?? 0;
      double itemPrice = double.tryParse(price) ?? 0.0;
      user.splitAmount = itemPrice * userQty;
      
    }
  }
}


bool checkQty({
  required int tabIndex,
}) {
  isValid = true; 
  final item = itemsList[tabIndex];
  int totalUserQty = 0;

  for (var user in item.users) {
    final qty = num.tryParse(user.qty.text) ?? 0;
    totalUserQty += qty.toInt(); 
  }

  final itemQty = num.tryParse(item.quantity.text) ?? 0;

  // Compare the total user quantity (as integer) with the item quantity (as integer)
  if (totalUserQty != itemQty.toInt()) {
    Customtoast.showErrorToast(
      "Total quantity of all users must match the item quantity."
    );
    isValid = false;
  } else {
    isValid = true;
  }

  notifyListeners(); 
  return isValid;
}


Future<void> addOrder() async {
  try {
    final List<ItemUploadingModel> order = [];

    // Iterate through the items and validate inputs
    for (var data in itemsList) {
      // Validate and parse price
      final num? price = num.tryParse(data.price.text);
      if (price == null || price <= 0) {
        log("Invalid price for item: ${data.name.text}, skipping this item.");
        continue;
      }

      // Validate and parse quantity
      final num? itemQty = num.tryParse(data.quantity.text);
      if (itemQty == null || itemQty <= 0) {
        log("Invalid quantity for item: ${data.name.text}, skipping this item.");
        continue;
      }

      // Ensure users are not null
      if (data.users == null || data.users.isEmpty) {
        log("No users found for item: ${data.name.text}, skipping this item.");
        continue;
      }

      // Add valid item to the order list
      order.add(
        ItemUploadingModel(
          id: data.id ?? "", // Fallback to empty string if id is null
          name: data.name.text.isNotEmpty ? data.name.text : "Unknown", // Fallback for name
          price: price,
          qty: itemQty,
          users: data.users,
        ),
      );
    }

    log("Total valid order items: ${order.length}");

    // Check if the order list is empty before proceeding
    if (order.isEmpty) {
      log("No valid items to add to the order.");
      return;
    }

    // Ensure overallTotal is valid
    if (overallTotal == null || overallTotal <= 0) {
      log("Invalid total amount: $overallTotal. Aborting order creation.");
      return;
    }

    // Call the addOrder function in the facade
    final result = await iOrderSummeryFacade.addOrder(
      orderModel: OrderModel(
        createdAt: Timestamp.now(),
        totalAmount: overallTotal,
        order: order,
      ),
    );

    // Handle the result of the addOrder call
    result.fold(
      (failure) {
        log("Add error: ${failure.toString()}");
      },
      (unit) {
        log("Order added successfully.");
      },
    );
  } catch (e) {
    log("Error in addOrder: $e");
  }
}

}
