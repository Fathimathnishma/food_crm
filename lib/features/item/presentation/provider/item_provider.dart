import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_crm/features/item/data/model/item_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class ItemProvider extends ChangeNotifier{
  final itemController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  List<ItemModel> localorder = [];
  num total =0;

Future<void> addOrderlocaly() async {
  if (itemController.text.isEmpty) {
    CustomFluttertoast.showToast("No data");
    return;
  }
  final quantity = int.tryParse(quantityController.text.trim());
  final price = int.tryParse(priceController.text.trim());
  if (quantity != null && price != null) {
    final rate = quantity * price; 
    final orderModel = ItemModel(
      item: itemController.text,
      quantity: quantity,
      price: price,
      rate: rate,
    );
    localorder.add(orderModel);

if(rate!=null){    
     total = 0;
    for (var order in localorder) {
      total += order.rate; 
    }
    log("Total: $total"); 
}
    clearController();
    notifyListeners();
  }
}

  void removeOrderByIndex(int index) {
    if (index < 0 || index >= localorder.length) {
      CustomFluttertoast.showToast("Invalid index");
      return;
    }
    localorder.removeAt(index);
    notifyListeners();
  }


  void clearData() {
    localorder = [];
    notifyListeners();
  }


  void clearController() {
    itemController.clear();
    quantityController.clear();
    priceController.clear();
    notifyListeners();
  }
}