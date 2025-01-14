import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';

class OrderSummeryProvider extends ChangeNotifier{
final IOrderSummeryFacade iOrderSummeryFacade;
OrderSummeryProvider(this.iOrderSummeryFacade);


 Future<void> fetchUser() async {
    final result = await iOrderSummeryFacade.fetchUsers();
    result.fold(
      (l) {
        l.toString();
      },
      (user) {
        for (var data in user) {
          UserItemQtyAloccatedModel(
              name: data.name,
              phoneNumber: data.phoneNumber,
              qtyController: TextEditingController(),
              id: data.id!);
        }
      },
    );
  }

}