import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderHistoryProvider with ChangeNotifier {
  final IOrderHistoryFacade iOrderFacade;
  OrderHistoryProvider(this.iOrderFacade);

  num total = 0;
  bool isLoading = false;
  bool noMoreData = false;
   
List<OrderModel>allOrders =[];
List<OrderModel> todayOrders = [];
Map<String, List<OrderModel>> groupedOrders = {};


void filterTodayOrders(List<OrderModel>todayOrder) {
 todayOrders=todayOrder;
 calculateTodayTotal();
 notifyListeners();
}


void calculateTodayTotal(){
  total=0;
  for(var order in todayOrders){
   total +=  order.totalAmount;
   
  }

}

  Future<void> fetchOrders() async {
    log('fetching');
    clearData();
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
        log('Calling filterTodayOrders');
        groupedOrders = groupOrdersByDate(allOrders);
      },
    );
    isLoading = false;
    notifyListeners();
  }

void clearData (){
  allOrders=[];
 
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

  void filterOrderBySpecificDateRange(DateTime startDate, DateTime endDate) {
    groupedOrders ={};



  List<OrderModel> filteredOrders = allOrders.where((order) {
    DateTime orderDate = order.createdAt.toDate();
    return orderDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
        orderDate.isBefore(endDate.add(const Duration(days: 1)));
  }).toList();

  groupedOrders = groupOrdersByDate(filteredOrders);

  notifyListeners();

  }


void selectDateRange(BuildContext context) async {
  final pickedDateRange = await showDateRangePicker(
    context: context,
    initialDateRange: DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),

  );

  if (pickedDateRange != null) {
    final startDate = pickedDateRange.start;
    final endDate = pickedDateRange.end;

    // Call the filter method from the provider
    final orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    orderHistoryProvider.filterOrderBySpecificDateRange(startDate, endDate);
  }
}


}
