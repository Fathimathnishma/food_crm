import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/add_item/data/i_item_facade.dart';
import 'package:food_crm/features/add_item/data/model/user_item_qty_aloccated_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class ItemProvider extends ChangeNotifier {
  final IItemFacade iItemFacade;
  ItemProvider(this.iItemFacade);

  final itemController = TextEditingController();
  final totalQuantityController = TextEditingController();
  final priceController = TextEditingController();


  List<ItemModel> localitemOrder = [];
  List<UserItemQtyAloccatedModel> users=[];
  num total = 0;

Future<void> fetchUser() async {
  final result = await iItemFacade.fetchUser();
  result.fold(
    (l) {
      l.toString();
    },
    (user) {
      for (var data in user) {
        final qtyController = TextEditingController();
        users.add(UserItemQtyAloccatedModel(
          id: data.id!,
          name: data.name,
          qtyController: qtyController,
          phoneNumber: data.phoneNumber,
        ));
      }
      notifyListeners();
    },
  );
}


  Future<void> addOrderlocaly() async {
    if (itemController.text.isEmpty) {
      CustomFluttertoast.showToast("No data");
      return;
    }
    final quantity = int.tryParse(totalQuantityController.text.trim());
    final price = int.tryParse(priceController.text.trim());
    num splitAmount = 0;

     if (quantity != null && price != null) {
    for (int i = 0; i < users.length; i++) {
      final qty = int.tryParse(users[i].qtyController.text.trim()) ?? 0;

      if (qty > 0) {
        splitAmount += qty * price; 
      }
    }

      final rate = quantity * price;

      final itemModel = ItemModel(
        item: itemController.text,
        quantity: quantity,
        price: price,
        rate: rate,
        splitAmount: splitAmount,
        id: itemController.text.toLowerCase().trim(),
        users: List<UserItemQtyAloccatedModel>.from(users),
      );

      localitemOrder.add(itemModel);

      total = 0;
      for (var order in localitemOrder) {
        total += order.rate;
      }

      log("Total: $total");

      clearController();
      notifyListeners();
    } else {
      CustomFluttertoast.showToast("Invalid quantity, price, or qty");
    }
  }

  void removeOrderByIndex(int index) {
    if (index < 0 || index >= localitemOrder.length) {
      CustomFluttertoast.showToast("Invalid index");
      return;
    }
    localitemOrder.removeAt(index);
    notifyListeners();
  }

 void clearData() {
    localitemOrder = [];
    notifyListeners();
  }

  void clearController() {
    itemController.clear();
    totalQuantityController.clear();
    priceController.clear();
    notifyListeners();
  }
}
