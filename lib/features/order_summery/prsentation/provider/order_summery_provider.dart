import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';

class OrderSummeryProvider extends ChangeNotifier {
  final IOrderSummeryFacade iOrderSummeryFacade;
  OrderSummeryProvider(this.iOrderSummeryFacade);

  List<ItemUploadingModel> itemsList = [];
  bool isLoading = false;
  num overallTotal = 0;

  void addItemToSummery(List<ItemUploadingModel> items) {
    overallTotal = 0;

    for (var item in items) {
      final num price = num.parse(item.price.text);
      final num itemQty = num.parse(item.quantity.text);
      final num itemTotal = price * itemQty;
      overallTotal += itemTotal;
    }
    itemsList = items;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();

    final result = await iOrderSummeryFacade.fetchUsers();
    result.fold(
      (l) {
        l.toString();
      },
      (user) {
        for (var item in itemsList) {
          item.users.addAll(
            user.map(
              (user) {
                return UserItemQtyAloccatedModel(
                  name: user.name,
                  phoneNumber: user.phoneNumber,
                  qtyController: TextEditingController(),
                  id: user.id!,
                  splitAmount: 0,
                  total: 0,
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

  void removeUserFromSummery({required int tabIndex, required int userIndex}) {
    itemsList[tabIndex].users.removeAt(userIndex);
    notifyListeners();
  }

  void updateSplitAmount({
    required int tabIndex,
    required int userIndex,
    required String price,
  }) {
    var user = itemsList[tabIndex].users[userIndex];
    if (user.qtyController.text.isEmpty) {
      user.splitAmount = 0;
    } else {
      num qty = num.parse(user.qtyController.text);
      double itemPrice = double.tryParse(price) ?? 0.0;
      user.splitAmount = itemPrice * qty;
    }

    notifyListeners();
  }




Future<void>addOrder() async {
  final result = await iOrderSummeryFacade.addOrder(
    orderModel: OrderModel(
      createdAt: Timestamp.now(),
      totalAmount:overallTotal , 
      order: itemsList
       ));

       result.fold((l) {
        l.toString();
       }, (unit) {
         
       },);

 }
}
