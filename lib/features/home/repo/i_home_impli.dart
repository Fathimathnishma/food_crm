
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/home/data/i_home_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IHomeFacade)
class IHomeImpli implements IHomeFacade {
 final FirebaseFirestore firebaseFirestore;

  IHomeImpli(this.firebaseFirestore);


  @override
  Future<Either<MainFailures, List<OrderModel>>> fetchTodayOrderList({required String todayDate}) async {
  try {
     final date = DateTime.parse(todayDate);
    final startOfDay = Timestamp.fromDate(DateTime(date.year, date.month, date.day));
    final endOfDay = Timestamp.fromDate(DateTime(date.year, date.month, date.day, 23, 59, 59, 999));

      log("Fetching orders...");
      final todayOrder = await firebaseFirestore
          .collection(FirebaseCollection.order)
          .where("createdAt" ,isGreaterThanOrEqualTo: startOfDay)
          .where("createdAt",isLessThanOrEqualTo: endOfDay)
          .orderBy("createdAt",descending: true).get();
    

      if (todayOrder.docs.isEmpty) {
        log("No orders found.");
        
      }
     final orders = todayOrder.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList();
      return right(orders);

    } catch (e) {
      log("Error while fetching orders: $e");
     
      return left(MainFailures.serverFailures(errormsg: e.toString())) ;
    }
  }
}