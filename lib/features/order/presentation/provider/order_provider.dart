import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_crm/features/order/data/model/i_order_facade.dart';
import 'package:food_crm/features/order/data/model/order_model.dart';

class OrderProvider with ChangeNotifier {
  final IOrderFacade iOrderFacade;
  OrderProvider({required this.iOrderFacade});

  final itemController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  bool isLoading = false;
  bool noMoreData = false;
  List<OrderModel> orderList = [];

  Future<void> addOrder() async {
    final quantity = int.tryParse(quantityController.text.trim());
    final price = int.tryParse(priceController.text.trim());
    final result = await iOrderFacade.addOrders(
        orderModel: OrderModel(
            item: itemController.text,
            quantity: quantity!,
            price: price!,
            createdAt: Timestamp.now()));

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        addLocally(success);
        log('Order added succesfully');
        notifyListeners();
      },
    );
  }

  Future<void> fetchOrders() async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();
    final result = await iOrderFacade.fetchOrders();

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        orderList.addAll(success);
        log('Ordrt fetched');
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteOrder({required String orderId}) async {
    final result = await iOrderFacade.deleteOrder(orderId: orderId);

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        orderList.removeWhere((or) => or.id == orderId);
        log('delete order succesfully');
        notifyListeners();
      },
    );
  }

  void clearOrderList() {
    orderList = [];
    notifyListeners();
  }

  void addLocally(OrderModel orderModel) {
    orderList.insert(0, orderModel);
  }

  Future<void> initData()async{
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchOrders();
    });
  }
}
