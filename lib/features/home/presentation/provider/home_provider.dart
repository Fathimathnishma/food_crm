import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/home/data/i_home_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:intl/intl.dart';

class HomeProvider with ChangeNotifier {
  final IHomeFacade iHomeFacade;
  HomeProvider(this.iHomeFacade);

  DateTime _dateTime = DateTime.now();
  DateTime get dateTime => _dateTime;

  String get formattedDate => DateFormat('EEE d').format(_dateTime);
  String get formattedTime => DateFormat('h:mm a').format(_dateTime);
  //StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? countListner;
  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  num usersCount = 0;
  List<OrderModel> todayOrders = [];
  num total = 0;
  num totalAmount = 0;
  bool isLoading = false;
  bool noMoreData = false;
  List<UserModel> users = [];



  void updateDateTime(DateTime newDateTime) {
    _dateTime = newDateTime;
    notifyListeners();
  }
 



  Future<void> fetchTodayOrderList() async {
    todayOrders=[];  
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();

    final result = await iHomeFacade.fetchTodayOrderList(todayDate: todayDate);
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

  Future<void> fetchUsers() async {
    users=[];
    final result = await iHomeFacade.fetchUser();
    result.fold(
      (l) {
        l.toString();
      },
      (userList) {
        users.addAll(userList);
        
        
        log("users${users.length.toString()}");
      },
     );  
        notifyListeners();
    
  }

  void calculateTodayTotal() {
    total = 0;
    for (var order in todayOrders) {
      total += order.totalAmount;
      //log("total${total.toString()}");
    }
  }

  // void clearData() {
    
  //   totalAmount=0;
  //   total = 0;
  // }

  
void addLocalTodayOrder(){
init();
notifyListeners();
}

void init(){
  //clearData();
fetchTodayOrderList();
fetchUsers();


}

Stream listenToUserCount() {
    return iHomeFacade
        .fetchUserCountTotal()
        .asyncMap((result) => result.fold(
              (failure) {
                log(failure.errormsg);
                return 0; // Return default value on failure
              },
              (success) {
                usersCount = success["userCount"] as num;
                totalAmount = success["totalAmount"] as num;
                return success;
              },
            ))
        .distinct(); // Only emit when value changes
 }
}