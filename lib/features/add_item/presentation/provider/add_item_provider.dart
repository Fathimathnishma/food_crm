// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:food_crm/features/add_item/data/i_add_item_facade.dart';
// import 'package:food_crm/features/add_item/data/model/item_model.dart';
// import 'package:food_crm/general/widgets/fluttertoast.dart';

// class AddItemProvider extends ChangeNotifier {
//   final IItemFacade iItemFacade;
//   AddItemProvider(this.iItemFacade);

//   List<ItemAddingModel> itemList = [];

//   List<ItemAddingModel> itemsuggestionList = [];

//   bool isLoading = true;
//   void addItem() {
//     itemList.add(
//       ItemAddingModel(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         name: TextEditingController(),
//         quantity: TextEditingController(),
//         price: TextEditingController(),
//         users: [],
//       ),
//     );
//     notifyListeners();
//   }

//   void removeItem(int index) {
//     itemList.removeAt(index);
//     notifyListeners();
//   }

//   Future<void> addSuggestions() async {
//     final result = await iItemFacade.addSuggestions(itemList: itemList);
//     result.fold(
//       (l) {
//         l.toString();
//       },
//       (r) {
//         log('suggestion added');
//       },
//     );
//   }

//   Future<void> fetchSugetion() async {
//     isLoading = true;
//     notifyListeners();
//     final resut = await iItemFacade.fetchSuggestions();

//     resut.fold(
//       (l) {
//         Customtoast.showErrorToast(l.errormsg);
//       },
//       (r) {
//         itemsuggestionList = r;
//       },
//     );
//     isLoading = false;
//     notifyListeners();
//   }

//   void disposeControllers(ItemAddingModel item) {
//     item.name.dispose();
//     item.quantity.dispose();
//     item.price.dispose();
//   }

//   void clearItems() {
//     for (var item in itemList) {
//       disposeControllers(item);
//     }
//     itemList.clear();
//     notifyListeners();
//   }
// }



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
      // Create a new list excluding the item to be removed
      List<ItemAddingModel> updatedList = [];
      
      for (int i = 0; i < itemList.length; i++) {
        if (i != index) {
          // Keep the item's existing controllers and values
          ItemAddingModel existingItem = itemList[i];
          updatedList.add(ItemAddingModel(
            id: existingItem.id,
            name: existingItem.name,
            quantity: existingItem.quantity,
            price: existingItem.price,
            users: existingItem.users,
          ));
        } else {
          // Dispose controllers of the removed item
          itemList[i].name.dispose();
          itemList[i].quantity.dispose();
          itemList[i].price.dispose();
        }
      }
      
      // Update the list with the remaining items
      itemList = updatedList;
      
      // If list is empty, add a new item
      if (itemList.isEmpty) {
        addItem();
      }
      
      notifyListeners();
    }
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
