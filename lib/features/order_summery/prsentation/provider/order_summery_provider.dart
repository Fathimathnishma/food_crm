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

  void splitQuantityAmongUsers(int itemIndex) {
  final item = itemsList[itemIndex];
  final totalQuantity = int.tryParse(item.quantity.text) ?? 0;
  final userCount = item.users.length;

  if (userCount == 0 || totalQuantity == 0) return;

  // Calculate equal split and remainder
  final equalSplit = totalQuantity ~/ userCount;
  final remainder = totalQuantity % userCount;

  for (int i = 0; i < userCount; i++) {
    // Distribute remainder to the first few users
    final allocatedQuantity = i < remainder ? equalSplit + 1 : equalSplit;
    item.users[i].qtyController.text = allocatedQuantity.toString();
  }

  notifyListeners();
}

void addUserToItem(int itemIndex, UserItemQtyAloccatedModel user) {
  final item = itemsList[itemIndex];
  item.users.add(user);
  splitQuantityAmongUsers(itemIndex); // Automatically distribute quantity
  notifyListeners();
}

void updateItemQuantity(int itemIndex, String newQuantity) {
  final item = itemsList[itemIndex];
  item.quantity.text = newQuantity;
  splitQuantityAmongUsers(itemIndex); // Automatically distribute quantity
  notifyListeners();
}


}
