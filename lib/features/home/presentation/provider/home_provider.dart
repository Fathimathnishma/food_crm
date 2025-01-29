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

  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  final _dateTimeController = StreamController<DateTime>.broadcast();

  Stream<DateTime> get dateTimeStream => _dateTimeController.stream;

  num usersCount = 0;
  List<OrderModel> todayOrders = [];
  num todayTotal = 0;
  num totalAmount = 0;
  num balanceAmount = 0;
  num depositAmount = 0;
  bool isLoading = false;
  bool noMoreData = false;
  List<UserModel> users = [];

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
    notifyListeners();
  }

  void calculateTodayTotal() {
    todayTotal = 0;
    for (var order in todayOrders) {
      todayTotal += order.totalAmount;
    }
  }

  void addLocalTodayOrder() {
    init();
    notifyListeners();
  }

  void init() {
    fetchTodayOrderList();
    fetchUsers();
  }

  Stream listenToUserCount() {
    return iHomeFacade
        .fetchUserCountTotal()
        .asyncMap((result) => result.fold(
              (failure) {
                log(failure.errormsg);
                return 0;
              },
              (success) {
                usersCount = success["userCount"] as num;
                totalAmount = success["totalAmount"] as num;
                depositAmount = success["depositAmount"] as num;
                balanceAmount = totalAmount - depositAmount;
                return success;
              },
            ))
        .distinct();
  }

  @override
  void dispose() {
    _dateTimeController.close();
    super.dispose();
  }
}
