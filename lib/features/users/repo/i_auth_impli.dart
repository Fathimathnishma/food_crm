import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

@LazySingleton(as: IUserFacade)
class IUserImpli implements IUserFacade {
  final FirebaseFirestore firestore;
  final FirebaseAuth fireauth;
  DocumentSnapshot? lastDoc;
  IUserImpli(this.firestore, this.fireauth);

  @override
  Future<Either<MainFailures, String>> addUser(
      {required UserModel usermodel}) async {
    try {
      final id = firestore.collection(FirebaseCollection.users).doc().id;

      final generalRef = firestore
          .collection(FirebaseCollection.general)
          .doc(FirebaseCollection.general);
      final userRef = firestore.collection(FirebaseCollection.users).doc(id);
      final user = usermodel.copyWith(id: id);
      final batch = firestore.batch();
      batch.set(userRef, user.toMap());
      batch.update(generalRef, {"userCount": FieldValue.increment(1)});

      await batch.commit();

      return right("User added");
    } catch (e) {
      log("Error while adding user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUser() async {
    log("fetching");
    try {
      final userRef = firestore
          .collection(FirebaseCollection.users)
          .orderBy("createdAt", descending: true);

      Query query = userRef.limit(10);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      final querySnapshot = await query.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, Unit>> removeUser(
      {required String userId}) async {
    try {
      final userDoc =
          firestore.collection(FirebaseCollection.users).doc(userId);
      await userDoc.delete();

      return right(unit);
    } catch (e) {
      log("Error while deleting user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, num>> fetchGeneral() async {
    try {
      final generalSnapshot =
          await firestore.collection("general").doc("general").get();
      final generalData = generalSnapshot.data();
      final count = generalData?["userCount"] ?? 0;
      return right(count);
    } catch (e) {
      log("Batch commit failed: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  
  @override
  Future<Either<MainFailures, OrderModel>> addDailyOrder(
      {required String userId, required OrderModel orderModel}) async {

        final today = await NtpTimeSyncChecker.getNetworkTime() ?? DateTime.now();

        final formattedDate = DateFormat('yyyy-MM-dd').format(today);
    try {
      final userDoc =
          firestore.collection(FirebaseCollection.users).doc(userId);

      final orderDoc =  userDoc.collection('dailyOrder').doc(formattedDate);

      final orderDocSnapshot = await orderDoc.get();
      if(orderDocSnapshot.exists){

        orderDoc.update({
          'totalAmount': FieldValue.increment(orderModel.totalAmount ),
          'createdAt': FieldValue.serverTimestamp(),
          'order': {

          }

        });
      }else{
        orderDoc.set({

        });
      }
      return right(orderModel);
      
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  
}
