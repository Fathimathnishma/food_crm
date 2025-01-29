import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/today_order/data/i_today_order_facade.dart';
import 'package:intl/intl.dart';

class TodayOrderProvider extends ChangeNotifier {
  final ITodayOrderFacade iTodayOrderFacade;
  TodayOrderProvider(this.iTodayOrderFacade);

  List<OrderModel> todayOrders = [];
  num total = 0;
  bool isLoading = false;
  bool noMoreData = false;

  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  Future<void> fetchTodayOrderList() async {
    todayOrders = [];
    isLoading = true;
    notifyListeners();
    final result =
        await iTodayOrderFacade.fetchTodayOrderList(todayDate: todayDate);
    result.fold(
      (l) {
        l.toString();
        isLoading = false;
      },
      (r) {
        log("added");
        todayOrders.addAll(r);
      },
    );

    isLoading = false;
    calculateTodayTotal();
    notifyListeners();
  }

  void calculateTodayTotal() {
    total = 0;
    for (var order in todayOrders) {
      total += order.totalAmount;
    }
  }

  void addLocalTodayOrder(OrderModel order) {
    todayOrders.add(order);
    calculateTodayTotal();
    notifyListeners();
  }
}
