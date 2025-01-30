import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/i_add_item_facade.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class AddItemProvider extends ChangeNotifier {
  final IItemFacade iItemFacade;
  AddItemProvider(this.iItemFacade);

  List<ItemAddingModel> itemList = [];
  List<ItemAddingModel> itemsuggestionList = [];
  bool isLoading = true;

  void addItem() {
    ItemAddingModel newItem = ItemAddingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: TextEditingController(),
      quantity: TextEditingController(),
      price: TextEditingController(),
      users: [],
    );
    itemList.add(newItem);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < itemList.length) {
      List<ItemAddingModel> updatedList = [];
      
      for (int i = 0; i < itemList.length; i++) {
        if (i != index) {
          ItemAddingModel existingItem = itemList[i];
          updatedList.add(ItemAddingModel(
            id: existingItem.id,
            name: existingItem.name,
            quantity: existingItem.quantity,
            price: existingItem.price,
            users: existingItem.users,
          ));
        } else {
          itemList[i].name.dispose();
          itemList[i].quantity.dispose();
          itemList[i].price.dispose();
        }
      }
      
      itemList = updatedList;
            if (itemList.isEmpty) {
        addItem();
      }
      
      notifyListeners();
    }
  }

  Future<void> addSuggestions({ required void Function() onSuccess,}) async {
    for(var data in itemList){
    if(  data.name.text.isEmpty&& data.quantity.text.isEmpty&& data.price.text.isEmpty){
      Customtoast.showErrorToast("please enter a value ");
      return;
    }
    final num? price = num.tryParse(data.price.text);
final num? quantity = num.tryParse(data.quantity.text);
if (price == null || price <= 0 || quantity == null || quantity <= 0) {
    Customtoast.showErrorToast("Please enter a valid value.");
    return;
}
    
    }
    final result = await iItemFacade.addSuggestions(itemList: itemList);
    result.fold(
      (l) {
        l.toString();
      },
      (r) {
        log('suggestion added');
        onSuccess();
      },
    );   
  }

  Future<void> fetchSugetion() async {
    isLoading = true;
    notifyListeners();
    
    final result = await iItemFacade.fetchSuggestions();
    result.fold(
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

  void disposeControllers(ItemAddingModel item) {
    item.name.dispose();
    item.quantity.dispose();
    item.price.dispose();
  }

  void clearItems() {
    for (var item in itemList) {
      disposeControllers(item);
    }
    itemList.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    clearItems();
    super.dispose();
 }
}
