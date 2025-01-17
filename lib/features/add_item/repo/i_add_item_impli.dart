
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/i_add_item_facade.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IItemFacade)
class IAddItemImpli implements IItemFacade {
  final FirebaseFirestore firestore;
  IAddItemImpli(this.firestore);

  @override
  Future<Either<MainFailures, Unit>> addSuggestions(
      {required List<ItemUploadingModel> itemList}) async {
    try {
      Map<String, dynamic> suggestionMap = {'suggestions': {}};

      for (var element in itemList) {
        // Skip invalid items
        if (element.name.text.isEmpty ||
            element.price.text.isEmpty ||
            element.quantity.text.isEmpty) {
          continue;
        }

        suggestionMap['suggestions']
            [element.name.text.toLowerCase().replaceAll(' ', '')] = {
          'name': element.name.text,
          'price': element.price.text,
          'quantity': element.quantity.text,
        };
      }

      final suggestionRef =
          firestore.collection(FirebaseCollection.general).doc('general');

      // Use set with merge to avoid document existence issues
      await suggestionRef.set(
        suggestionMap,
        SetOptions(merge: true),
      );

      return right(unit);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<ItemUploadingModel>>>
      fetchSuggestions() async {
    try {
      final result = await firestore
          .collection(FirebaseCollection.general)
          .doc('general')
          .get();
      List<ItemUploadingModel> itemsuggestionList = [];
      (result.data()?['suggestions'] as Map? ?? {}).forEach(
        (key, value) {
          final name = TextEditingController(text: value['name']);
          final quantity = TextEditingController(text: value['quantity']);
          final price = TextEditingController(text: value['price']);
          itemsuggestionList.add(
            ItemUploadingModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: name,
              quantity: quantity,
              price: price,
              users: [],
              
            ),
          );
        },
      );
      return right(itemsuggestionList);
    } on Exception catch (e) {
      return left(
        MainFailures.serverFailures(
          errormsg: e.toString(),
        ),
      );
    }
  }
  
 
}
