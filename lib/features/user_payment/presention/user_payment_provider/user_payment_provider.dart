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
 

  Future<void> fetchUserPayment({required String userId}) async {
    userOrder=[];
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
  }

  Future<void> addUsers({required List<UserModel>user}) async {
  users.addAll(user);
  notifyListeners();
  }

  num getMonthlyTotalForUser({ required List<OrderDailyReportModel> userOrders,}) {
    num total=0;
    for (var order in userOrders) {
      for (var item in order.items!) {
        total += item.splitAmount;
        log(total.toString());
      }
    }
    return total ;
  }

  void clearData() {
    userOrder = [];
    users=[];
   notifyListeners();
  }
}
