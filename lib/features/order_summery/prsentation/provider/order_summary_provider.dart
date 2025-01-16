import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summary_facade.dart';

class OrderSummaryProvider with ChangeNotifier {
  final IOrderSummaryFacade iOrderSummaryFacade;
  OrderSummaryProvider({required this.iOrderSummaryFacade});

  List<UserItemQtyAloccatedModel> userList = [];

  Future<void> fetchUsers() async {
    final result = await iOrderSummaryFacade.fetchUsers();

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (succes) {
        for (var user in succes) {
          userList.add(UserItemQtyAloccatedModel(
              name: user.name,
              phoneNumber: user.phoneNumber,
              id: user.id.toString(),
              qtyController: TextEditingController()));

          log('Fetched ${userList.length} users.');
          notifyListeners();
        }
      },
    );
  }
}
