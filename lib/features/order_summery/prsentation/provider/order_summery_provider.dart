import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';

class OrderSummeryProvider extends ChangeNotifier {
  final IOrderSummeryFacade iOrderSummeryFacade;
  OrderSummeryProvider(this.iOrderSummeryFacade);

  List<ItemUploadingModel> itemsList = [];
  void addItemToSummery(List<ItemUploadingModel> items) {
    itemsList = items;
  }

  bool isLoading = false;

  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();
    final result = await iOrderSummeryFacade.fetchUsers();
    result.fold(
      (l) {
        l.toString();
      },
      (user) {
        for (var item in itemsList) {
          item.users.addAll(
            user.map(
              (user) {
                return UserItemQtyAloccatedModel(
                  name: user.name,
                  phoneNumber: user.phoneNumber,
                  qtyController: TextEditingController(),
                  id: user.id!,
                );
              },
            ).toList(),
          );
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void removeUserFromSummery({required int tabIndex, required int userIndex}) {
    itemsList[tabIndex].users.removeAt(userIndex);
    notifyListeners();
  }
}
