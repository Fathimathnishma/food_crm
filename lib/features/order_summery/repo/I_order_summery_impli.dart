import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

@LazySingleton(as: IOrderSummeryFacade)
class IOrderSummeryImpli implements IOrderSummeryFacade {
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
        return UserModel.fromMap(e.data());
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, Unit>> addOrder(
      {required OrderModel orderModel,required String foodTime}) async {
    try {
      final orderRef = firestore.collection(FirebaseCollection.order);
      final id = orderRef.doc().id;
      final orderDoc = firestore.collection(FirebaseCollection.order).doc(id);
      final today = await NtpTimeSyncChecker.getNetworkTime() ?? DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(today);


      final Map<String, dynamic> itemMap = {};
      for (var item in orderModel.order) {
        itemMap[item.name] = {
          'name': item.name,
          'price': item.price,
          'qty': item.qty,
          'users': {
            for (var user in item.users) user.id: user.toMap(),
          },
        };
      }

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
          if (item.users.contains(user)) {
            final userDoc =
                firestore.collection(FirebaseCollection.users).doc(user.id);
            final userOrderDoc =
                userDoc.collection(FirebaseCollection.dailyOrders).doc(formattedDate);
            final userOrderDocSnapshot = await userOrderDoc.get();
            final qty = num.parse(user.qty.text);
            final userItemMap ={
             
              item.name: UserDialyOrderModel(
                foodTime: foodTime,
                name: item.name,
                qty: qty,
                splitAmount: user.splitAmount,
              ).toMap(),
            };
            log("added");
            if (userOrderDocSnapshot.exists) {
              batch.set(userOrderDoc, {"item": userItemMap, "createdAt": FieldValue.serverTimestamp(),}, SetOptions(merge: true));
            } else {
              batch.set(
                  userOrderDoc, {"item": userItemMap,"createdAt": FieldValue.serverTimestamp()}, SetOptions(merge: true));
            }
            batch.update(
              FirebaseFirestore.instance
                  .collection(FirebaseCollection.users)
                  .doc(user.id),
              {
                'monthlyTotal': FieldValue.increment(user.splitAmount),
                
              },
            );
            log('Updating user ${user.id} monthlyTotal by ${user.splitAmount}');

          }
        }
      }

      // Commit the batch operation
      await batch.commit();

      return right(unit);
    } catch (e) {
      log("Error while adding order: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}
