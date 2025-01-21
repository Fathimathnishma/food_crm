import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';

class UserPaymentProvider with ChangeNotifier{
  final IUserPaymentFacade iUserPaymentFacade;
  UserPaymentProvider(this.iUserPaymentFacade);

   List<Map<String, dynamic>>? userPayments;

  Future<void> fetchUserPayment({required String userId})async{
    final result = await iUserPaymentFacade.fetchUserPayment(userId: userId);

    result.fold((failure) {
      log(failure.errormsg);
    }, (success) {
      userPayments = success;
      notifyListeners();
    },);
  }
}