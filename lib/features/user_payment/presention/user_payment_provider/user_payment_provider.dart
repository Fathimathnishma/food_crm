import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';

class UserPaymentProvider with ChangeNotifier {
  final IUserPaymentFacade iUserPaymentFacade;
  UserPaymentProvider(this.iUserPaymentFacade);

  UserDialyOrderModel? userPayment;

  List<dynamic> userOrderList = [];

  Future<void> fetchUserPayment({required String userId}) async {
    final result = await iUserPaymentFacade.fetchUserPayment(userId: userId);

    result.fold(
      (failure) {
        log(failure.errormsg);
        log('failed');
      },
      (success) {
        // for (var payment in success) {
        //   log('Name : ${payment.name},\nqty : ${payment.qty},\nsplitamount :${payment.splitAmount},\ncreatedAt : ${payment.createdAt}');
        // }
        if (success != null) {
          userPayment = success;
        }
        notifyListeners();
        log('success');
      },
    );
  }

  num get todayTotalAmount {
    num amount = 0;
    if (userPayment != null) {}
    return amount;
  }

  // Future<void> fetchUserDailyOrder({required String userId}) async {
  //   final result = await iUserPaymentFacade.fetchUserDailyOrder(userId: userId);

  //   result.fold(
  //     (failure) {
  //       log(failure.errormsg);
  //     },
  //     (success) {
  //       userOrderList = success;
  //     },
  //   );
  //   notifyListeners();
  // }
}
