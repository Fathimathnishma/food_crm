import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/utils/dialy_enum.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class OrderSummeryProvider extends ChangeNotifier {
  final IOrderSummeryFacade iOrderSummeryFacade;
  OrderSummeryProvider(this.iOrderSummeryFacade);

  List<ItemAddingModel> itemsList = [];
  bool isLoading = false;
  num overallTotal = 0;
  bool isValid = true;
  FoodTime selectedMeal = FoodTime.breakfast;
  void addItemToSummery(List<ItemAddingModel> items) {
    overallTotal = 0;

    for (var item in items) {
      final num price = num.parse(item.price.text);
      final num itemQty = num.parse(item.quantity.text);
      final num itemTotal = price * itemQty;
      overallTotal += itemTotal;
    }
    itemsList=items;
  }

  void init(List<ItemAddingModel> items){
     addItemToSummery(items);
    fetchUser();
    initiolSplitQty();
  }

  Future<void> fetchUser() async {

    log("message");
    final result = await iOrderSummeryFacade.fetchUsers();
    result.fold(
      (l) {
        log("Error fetching users: ${l.toString()}");
      },
      (userList) {
        if(itemsList.isNotEmpty){
        for (var item in itemsList) {
          item.users=[];
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
          initiolSplitQty();
        }
        }
        notifyListeners();
      },
    );

  }



String mealToString(FoodTime meal) {
    switch (meal) {
      case FoodTime.breakfast:
        return 'Breakfast';
      case FoodTime.lunch:
        return 'Lunch';
      case FoodTime.dinner:
        return 'Dinner';
    
    }
  }







void removeUserFromSummery({
  required int tabIndex,
  required int userIndex,
  required String price,
}) {
  if (userIndex >= 0 && userIndex < itemsList[tabIndex].users.length) {
    itemsList[tabIndex].users.removeAt(userIndex);

    if (itemsList[tabIndex].users.isNotEmpty) {
      initiolSplitQty();  
      updateSplitAmount(tabIndex: tabIndex, price: price); 
    }
    else {
      log("No users left in the list after removal for tabIndex: $tabIndex.");
    }
  }
  notifyListeners();
}





  void updateSplitAmount({
    required int tabIndex,
    required String price,
  }) {
    for (int userIndex = 0;
        userIndex < itemsList[tabIndex].users.length;
        userIndex++) {
      final user = itemsList[tabIndex].users[userIndex];
      final num qty = num.tryParse(user.qty.text) ?? 0;

    final double itemPrice = double.tryParse(price) ?? 0.0;
    user.splitAmount = itemPrice * qty;
  }
}







void initiolSplitQty() {
 for(var item in itemsList){
  for(var user in item.users){
    final num totalPrice = num.tryParse(item.price.text)??0;
     final num totalQty = num.tryParse(item.quantity.text)??0;
     final num qtyPerUser = totalQty / item.users.length;
      String formattedQty;
      if (qtyPerUser == qtyPerUser.toInt()) {
        formattedQty = qtyPerUser.toInt().toString(); 
      } else {
        formattedQty = qtyPerUser.toStringAsFixed(1); 
      }
     user.qty.text = formattedQty;
     num userQty = num.tryParse(formattedQty) ?? 0;
      user.splitAmount = totalPrice * userQty;
  }
 }

}

  bool checkQty({
    required int tabIndex,
  }) {
    isValid = true;
    final item = itemsList[tabIndex];
    num totalUserQty = 0;

    for (var user in item.users) {
      if (user.qty.text.isNotEmpty) {
      final qty = num.tryParse(user.qty.text);
      if (qty == null) {
        Customtoast.showErrorToast(
            "Invalid quantity entered for user: ${user.name}");
        isValid=false;
        return false; 
      }
      totalUserQty += qty;
    } else {
      Customtoast.showErrorToast(
          "Quantity cannot be empty for user: ${user.name}");
           isValid=false;
           return false;
    }
     
    }

    final itemQty = num.tryParse(item.quantity.text) ;
    if (totalUserQty != itemQty) {
      Customtoast.showErrorToast(
          "Total quantity of all users must match the item quantity.");
     return isValid = false;
      
    } else {
       isValid = true;
    }

    notifyListeners();
    return isValid;
  }

 Future<void> addOrder({ required void Function(OrderModel) onSuccess,}) async {
  final List<ItemUploadingModel> order = []; 
  for (var data in itemsList) {
    final num price = num.parse(data.price.text);
    final num itemQty = num.parse(data.quantity.text);
    
    order.add(
      ItemUploadingModel(
      
        name: data.name.text, 
        price: price, 
        qty: itemQty, 
        users: data.users
      )
    );
  }

    log("Total order length: ${order.length}");

    final result = await iOrderSummeryFacade.addOrder(
        orderModel: OrderModel(
            createdAt: Timestamp.now(),
            totalAmount: overallTotal,
            order: order), 
            foodTime:mealToString(selectedMeal).toLowerCase());

    result.fold(
      (l) {
        log("Add error: ${l.toString()}");
      },
      (unit) {
        onSuccess( OrderModel(
            createdAt: Timestamp.now(),
            totalAmount: overallTotal,
            order: order));
       
      },
    );
  }
}
