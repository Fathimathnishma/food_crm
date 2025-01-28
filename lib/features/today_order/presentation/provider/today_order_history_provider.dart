import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:intl/intl.dart';

class TodayOrderProvider extends ChangeNotifier {

List<OrderModel> todayOrders = [];
 num total = 0;
 String todayDate = DateFormat('dd MMMM ').format(DateTime.now());
 
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
void addLocalTodayOrder(OrderModel order){
todayOrders.add(order);
calculateTodayTotal();
notifyListeners();
}

}