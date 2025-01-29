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



 

  void clearData() {
    userOrder = [];
    users=[];
   notifyListeners();
  }

  num getTotalForOrder(OrderDailyReportModel order) {
  num total = 0;
  if (order.items != null) {
    for (var item in order.items!) {
      total += item.splitAmount; 
     
    }
  }
  return total;
}

Future<void>markPayment({required num paidAmount}) async {
  final result = await iUserPaymentFacade.makePayment(paidAmount: paidAmount);
  result.fold((l) {
    l.toString();
  }, (r) {
    log("finally paid");
  },);
}

 Future<void> fetchUsers() async {
     if (isLoading || noMoreData) return;
     isLoading = true;
    notifyListeners();
    final result = await iUserPaymentFacade.fetchUser();
    result.fold(
      (l) {
        l.toString();
      },
      (userList) {
        users.addAll(userList);
        log("users${users.length.toString()}");
      },
     );   isLoading = false;
    notifyListeners();

    
  }



}
