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

  void removeItem(int index) {
    itemList.removeAt(index);
    notifyListeners();
  }

  Future<void> addSugetion() async {
    final result = await iItemFacade.addSuggestions(itemList: itemList);
    result.fold(
      (l) {
        l.toString();
      },
      (r) {},
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
