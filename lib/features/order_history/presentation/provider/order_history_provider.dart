import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';

class OrderHistoryProvider with ChangeNotifier {
  final IOrderHistoryFacade iOrderFacade;
  OrderHistoryProvider(this.iOrderFacade);

  num total = 0;
  bool isLoading = false;
  bool noMoreData = false;

  List<OrderModel> allOrders = [];
  List<OrderModel> todayOrders = [];
  Map<String, List<OrderModel>> groupedOrders = {};

  String formatCreatedAt(Timestamp timestamp) {
    // Convert Firebase Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime to the desired format
    String formattedDate = DateFormat('dd MMMM ').format(dateTime);

    return formattedDate;
  }

  void filterTodayOrders() {
    todayOrders.clear();
    String todayDate = DateFormat('dd MMMM').format(DateTime.now());
    if (allOrders.isEmpty) {
      log("No orders found in allOrders");
      return;
    }
    todayOrders.addAll(allOrders.where((order) {
      String orderDate = DateFormat('dd MMMM').format(order.createdAt.toDate());
      return orderDate == todayDate;
    }).toList());
    calculateTodayTotal();
    notifyListeners();
  }

  void calculateTodayTotal() {
    total = 0;
    for (var order in todayOrders) {
      total += order.totalAmount;
      //log("total${total.toString()}");
    }
  }

  Future<void> fetchOrders() async {
    log('fetching');
    clearData();
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();
    log('1');
    final result = await iOrderFacade.fetchOrderList();

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        allOrders.addAll(success);
        log('Order fetched');
        filterTodayOrders();
        groupedOrders = groupOrdersByDate(allOrders);
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void clearData() {
    allOrders = [];
    todayOrders = [];
    total = 0;
  }

  Map<String, List<OrderModel>> groupOrdersByDate(List<OrderModel> allOrders) {
    Map<String, List<OrderModel>> groupedOrders = {};

    for (var order in allOrders) {
      String dateKey =
          DateFormat('dd MMMM yyyy').format(order.createdAt.toDate());

      if (groupedOrders.containsKey(dateKey)) {
        groupedOrders[dateKey]!.add(order);
      } else {
        groupedOrders[dateKey] = [order];
      }
    }

    return groupedOrders;
  }

  void filterOrderBySpecificDateRange(DateTime startDate, DateTime endDate) {}
}
