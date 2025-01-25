import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/features/user_payment/data/model/user_payment_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';

class UserPaymentProvider with ChangeNotifier {
  final IUserPaymentFacade iUserPaymentFacade;
  UserPaymentProvider(this.iUserPaymentFacade);

  List<OrderDailyReportModel> userOrder = [];
  List<UserModel> users = [];

  bool isLoading = false;
  bool noMoreData = false;
  Future<void> fetchUserPayment({required String userId}) async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();
    userOrder = [];

    final result = await iUserPaymentFacade.fetchUserPayment(userId: userId);

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {
        userOrder.addAll(success);
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> addUsers({required List<UserModel> user}) async {
    users.addAll(user);
    notifyListeners();
  }

 

  void clearData() {
    userOrder = [];
    users=[];
   notifyListeners();
  }

  num getTotalForOrder(OrderDailyReportModel order) {
  num total = 0;
  // Check if the order has items and calculate the total
  if (order.items != null) {
    for (var item in order.items!) {
      total += item.splitAmount;  // Add the splitAmount for each item
      log('Item: ${item.name}, Amount: ${item.splitAmount}');
    }
  }
  return total;
}
}
