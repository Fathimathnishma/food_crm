import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';

class OrderHistoryProvider with ChangeNotifier {
  final IOrderHistoryFacade iOrderHistoryFacade;
  OrderHistoryProvider(this.iOrderHistoryFacade);

 
  bool isLoading = false;
  bool noMoreData = false;
List<OrderModel>allOrders =[];

Map<String, List<OrderModel>> groupedOrders = {};

  Future<void> fetchOrders() async {
  if (isLoading || noMoreData) return;

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


void clearData (){
  iOrderHistoryFacade.clearData();
  isLoading=false;
  allOrders=[];
 
}
 String calculateTotal(List<ItemUploadingModel> items) {
    final total = items.fold<num>(
      0,
      ( sum, item) => sum + (item.price ),
    );
    return total.toString();
  }

String calculateTotalForDate(String dateKey) {

  final orders = groupedOrders[dateKey] ?? [];

  final total = orders.fold<num>(
    0,
    (sum, order) => sum + order.order.fold<num>(
      0,
      (itemSum, item) => itemSum + item.price,
    ),
  );
  return total.toStringAsFixed(2); 
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
Future<void>initData({ required ScrollController scrollController}) async {
  clearData();
    await fetchOrders();
  scrollController.addListener(() async {
  if (scrollController.position.pixels >=
      scrollController.position.maxScrollExtent - 70) {
    if (!isLoading && !noMoreData) {
      await fetchOrders();
    }
  }
});  
}
 
}