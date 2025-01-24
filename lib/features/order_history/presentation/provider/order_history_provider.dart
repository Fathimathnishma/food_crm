

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';


class OrderHistoryProvider with ChangeNotifier {
  final IOrderHistoryFacade iOrderFacade;
  OrderHistoryProvider( this.iOrderFacade);

  num total=0;
  bool isLoading = false;
  bool noMoreData = false;
  List<OrderModel>allOrders =[];
  List<OrderModel> todayOrders = [];




  String formatCreatedAt(Timestamp timestamp) {
  // Convert Firebase Timestamp to DateTime
  DateTime dateTime = timestamp.toDate();

  // Format the DateTime to the desired format
  String formattedDate = DateFormat('dd MMMM ').format(dateTime);

  return formattedDate;
}
   void filterTodayOrders() {
   // log("Filtering started");
   String todayDate = DateFormat('dd MMMM').format(DateTime.now());
 
   todayOrders.clear();

   if (allOrders.isEmpty) {
    log("No orders found in allOrders");
    return;
  }

  todayOrders.addAll(allOrders.where((order) {
    String orderDate = DateFormat('dd MMMM').format(order.createdAt.toDate());
    return orderDate == todayDate;
  }).toList());
   calculateTodayTotal();
  
}


  void calculateTodayTotal(){
    total=0;
    for(var order in todayOrders){
    total +=  order.totalAmount;
    //log("total${total.toString()}");
    notifyListeners();
  }

  notifyListeners();
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
      },
     );
       isLoading = false;
       notifyListeners();
    }

   void clearData (){
     allOrders=[];
     todayOrders=[];
     total=0;
   }

    void filterOrderBySpecificDateRange(DateTime startDate , DateTime endDate){

    }

}
