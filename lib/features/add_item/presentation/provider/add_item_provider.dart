import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/i_add_item_facade.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class AddItemProvider extends ChangeNotifier {
  final IItemFacade iItemFacade;
  AddItemProvider(this.iItemFacade);

  List<ItemUploadingModel> itemList = [];
  
  List<ItemUploadingModel> itemsuggestionList = [];

  bool isLoading = true;

  void addItem() {
    itemList.add(
      ItemUploadingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: TextEditingController(),
        quantity: TextEditingController(),
        price: TextEditingController(),
        users: [],
      ),
    );
    notifyListeners();
  }

  // List<UserItemQtyAloccatedModel> itemAloccatedUsers = [];
  // void generateItems(List<UserModel> users) {
  //   for (var user in users) {
  //     itemAloccatedUsers.add(
  //       UserItemQtyAloccatedModel(
  //           name: user.name,
  //           phoneNumber: user.phoneNumber,
  //           id: user.id ?? "",
  //           qtyController: TextEditingController()),
  //     );
  //   }

  //   log(itemAloccatedUsers.toString());
  //   for (var element in itemList) {
  //     log(element.users.length.toString());
  //     element = element.copyWith(users: itemAloccatedUsers);
  //   }
  //   notifyListeners(); 
  // }

  // void generateItems(List<UserModel> users) {
  //   for (var i = 0; i < itemList.length; i++) {
  //     final uniqueUsers = users.map((user) {
  //       return UserItemQtyAloccatedModel(
  //         name: user.name,
  //         phoneNumber: user.phoneNumber,
  //         id: user.id ?? "",
  //         qtyController: TextEditingController(),
  //       );
  //     }).toList();

  //     itemList[i] = itemList[i].copyWith(users: uniqueUsers);
  //   }

  //   log(itemList.map((e) => e.users.length).toString());
  //   notifyListeners();
  // }

  void removeItem(int index) {
    itemList.removeAt(index);
    notifyListeners();
  }

  Future<void> addSuggestions() async {
    final result = await iItemFacade.addSuggestions(itemList: itemList);
    result.fold(
      (l) {
        l.toString();
      },
      (r) {
        log('suggestion added');
      },
    );
  }

  Future<void> fetchSugetion() async {
    isLoading = true;
    notifyListeners();
    final resut = await iItemFacade.fetchSuggestions();

    resut.fold(
      (l) {
        Customtoast.showErrorToast(l.errormsg);
      },
      (r) {
        itemsuggestionList = r;
      },
    );
    isLoading = false;
    notifyListeners();
  }

 
}
