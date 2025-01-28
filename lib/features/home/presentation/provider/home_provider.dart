import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? countListner;
  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    final _dateTimeController = StreamController<DateTime>();

    Stream<DateTime> get dateTimeStream => _dateTimeController.stream;


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

   void startDateTimeStream() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = DateTime.now();
      _dateTimeController.add(_dateTime);
    });
  }

  

  Future<void> fetchTodayOrderList() async {
    todayOrders = [];
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
    users = [];
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
    totalAmount = 0;
    for (var user in users) {
      totalAmount += user.monthlyTotal;
    }
    log("totalAmount $totalAmount");
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

  void addLocalTodayOrder() {
    init();
    notifyListeners();
  }

  void init() {
    //clearData();
    fetchTodayOrderList();
    fetchUsers();
  }

  Stream<num> listenToUserCount() {
    return iHomeFacade
        .getUsersCountStream()
        .asyncMap((result) => result.fold(
              (failure) {
                log(failure.errormsg);
                return 0; // Return default value on failure
              },
              (success) {
                usersCount = success;
                return success;
              },
            ))
        .distinct(); // Only emit when value changes
  }

   @override
  void dispose() {
    _dateTimeController.close();
    super.dispose();
  }
}

