import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';

class OrderHistoryProvider with ChangeNotifier {
  final IOrderHistoryFacade iOrderHistoryFacade;
  OrderHistoryProvider(this.iOrderHistoryFacade);

  bool isLoading = false;
  bool noMoreData = false;
  bool isFiltered = false;
  List<OrderModel> allOrders = [];
  int todayDate = DateTime.now().day;
  Map<String, List<OrderModel>> groupedOrders = {};

  Future<void> fetchOrders() async {
    if (isLoading || noMoreData || isFiltered) return;
    isLoading = true;
    notifyListeners();
    final result = await iOrderHistoryFacade.fetchOrderList();

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        if (success.isEmpty) {
          noMoreData = true;
        } else {
          allOrders.addAll(success);
          groupedOrders = groupOrdersByDate(allOrders);
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void clearData() {
    iOrderHistoryFacade.clearData();
    isLoading = false;
    isFiltered=false;
    allOrders = [];
    groupedOrders={};
    
  }
void clearFilter(){
  isLoading = false;
   groupedOrders={};
    notifyListeners();
}

  String calculateTotalForDate(String dateKey) {
    final orders = groupedOrders[dateKey] ?? [];

    final total = orders.fold<num>(
      0,
      (sum, order) =>
          sum +
          order.order.fold<num>(
            0,
            (itemSum, item) => itemSum +(item.price*item.qty) ,
          ),
    );
    return total.toStringAsFixed(2);
  }

  Future<void> filterOrderBySpecificDateRange(
      DateTime startDate, DateTime endDate) async {
    groupedOrders = {};
   isFiltered = true;
    final result = await iOrderHistoryFacade.fetchOrderByRange(
        startDate: startDate, endDate: endDate);
    result.fold(
      (l) {
        l.toString();
      },
      (filteredOrders) {
        groupedOrders = groupOrdersByDate(filteredOrders);
      },
    );

    notifyListeners();
  }
Future<void>filterOrderBySpecificDate(DateTime selectedDate)async{

  log("one dae selected");

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
 void resetFilter() {
    isFiltered = false;
    notifyListeners();
    fetchOrders(); 
  }
  Future<void> initData({required ScrollController scrollController}) async {
    clearData();
    await fetchOrders();
    scrollController.addListener(() async {
  if (scrollController.position.pixels >=
      scrollController.position.maxScrollExtent - 70) {
    if (!isLoading && !noMoreData) {
      log("Fetching more orders...");
      await fetchOrders();
    }
  }}
);
  }
}
