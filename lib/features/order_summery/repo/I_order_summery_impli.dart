
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: IOrderSummeryFacade)
class IOrderSummeryImpli implements IOrderSummeryFacade{
   final FirebaseFirestore firestore;
  IOrderSummeryImpli(this.firestore);

  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUsers() async {
try {
      final userRef = firestore
          .collection(FirebaseCollection.users)
          .orderBy("createdAt", descending: true);
      final querySnapshot = await userRef.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data() );
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

@override
Future<Either<MainFailures, Unit>> addOrder({required OrderModel orderModel}) async {
  try {
    final orderRef = firestore.collection(FirebaseCollection.order);
    final id = orderRef.doc().id;
    final orderDoc = firestore.collection(FirebaseCollection.order).doc(id);
    final Map<String, dynamic> itemMap = {
      for (var item in orderModel.order)
        item.name.text: {
          'name': item.name.text,
          'price': item.price.text,
          'quantity': item.quantity.text,
          'users': {
            for (var user in item.users)
              user.id: user.toMap(),
          },
        }
    };

    final Map<String, dynamic> orderData = {
      'id': id,
      'createdAt': orderModel.createdAt,
      'totalAmount': orderModel.totalAmount,
      'order': itemMap,
    };
    final batch = firestore.batch();

    batch.set(orderDoc, orderData);

    for (var item in orderModel.order) {
      for (var user in item.users) {
        batch.update(
          FirebaseFirestore.instance.collection(FirebaseCollection.order).doc(user.id),
          {
            'monthlyTotal': FieldValue.increment(user.splitAmount), 
          },
        );
      }
    }

    await batch.commit();

    return right(unit);
  } catch (e) {
    log("Error while adding order: $e");
    return left(MainFailures.serverFailures(errormsg: e.toString()));
  }
}

}