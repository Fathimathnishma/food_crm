import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_crm/features/order/data/model/i_order_facade.dart';
import 'package:food_crm/features/order/data/model/order_model.dart';
import 'package:food_crm/features/order/data/model/service_order_model.dart';
import 'package:food_crm/general/utils/collection_const.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';
import 'package:injectable/injectable.dart';

class OrderProvider with ChangeNotifier {
  final IOrderFacade iOrderFacade;
  OrderProvider({required this.iOrderFacade});

  final itemController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  bool isLoading = false;
  bool noMoreData = false;
  num total = 0;
  List<OrderModel> localorder = [];
  List<ServiceOrderModel> orderList = [];


Future<void> add() async {
  if (itemController.text.isEmpty) {
    CustomFluttertoast.showToast("No data");
    return;
  }

  final quantity = int.tryParse(quantityController.text.trim());
  final price = int.tryParse(priceController.text.trim());
  final orderRef = FirebaseFirestore. instance.collection(Collection.order);
    final id = orderRef.doc().id;  
  
  if (quantity != null && price != null) {
    final rate = quantity * price;
    final ordermodel = OrderModel(
      id: id,
      item: itemController.text,
      quantity: quantity,
      price: rate,
      createdAt: Timestamp.now(),
    );

    final result = await iOrderFacade.addOrders(ordermodel: ordermodel);
    result.fold(
      (failure) => log("Failed to add order: ${failure.toString()}"),
      (_) {
        localorder.add(ordermodel);
        log("Order added successfully to local list");
      },
    );

    clearController();
    notifyListeners();
  }
}
Future<void> addOrders() async {
  if (localorder.isEmpty) {
    log("No orders to submit");
    return;
  }

  total = 0; 
  for (var order in localorder) {
    total += order.price;
  }
  log("Total: $total");
  log(order.toString());
 
  final orderMaps = localorder.map((order) => order.toMap()).toList();
  final result = await iOrderFacade.addOrderList(
    ordermodel: ServiceOrderModel(
      createdAt: Timestamp.now(),
      orders: orderMaps,
    ),
  );

  result.fold(
    (failure) => log("Failed to add orders: ${failure.toString()}"),
    (_) {
      log("Orders added successfully to services");
      localorder.clear(); 
    },
  );

  notifyListeners();
}


  // Future<void> fetchOrders() async {
  //   if (isLoading || noMoreData) return;
  //   isLoading = true;
  //   notifyListeners();
  //   final result = await iOrderFacade.fetchOrders();
  //   result.fold(
  //     (failure) {
  //       log(failure.errormsg);
  //     },
  //     (success) {
  //       log('Ordrt fetched');
  //     },
  //   );
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> removeOrder({required int index,required String orderId}) async {
    final result =await iOrderFacade.deleteOrder(orderId:orderId );
    result.fold((l) {
      l.toString();
    }, (r) {
      if (index < 0 || index >= localorder.length) {
      CustomFluttertoast.showToast("Invalid index");
      return;
    }
    r;
    localorder.removeAt(index);
    notifyListeners();
    },);
    
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
