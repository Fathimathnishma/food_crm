import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderHistoryFacade)
class IOrderHistoryImpl implements IOrderHistoryFacade {
  final FirebaseFirestore firebaseFirestore;

  IOrderHistoryImpl({required this.firebaseFirestore});

  bool noMoreData = false;
  DocumentSnapshot? lastDocument;

  @override
  Future<Either<MainFailures, List<OrderModel>>> fetchOrderList() async {
    try {
      log("Fetching orders...");

      // Fetching the Firestore collection
      final orderCollection = firebaseFirestore
          .collection(FirebaseCollection.order)
          .orderBy("createdAt");
      final querySnapshot = await orderCollection.limit(10).get();

      if (querySnapshot.docs.isEmpty) {
        log("No orders found.");
        return right([]);
      }
     final orders = querySnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList();
      return right(orders);

    } catch (e, stackTrace) {
      log("Error while fetching orders: $e");
      log("Stack trace: $stackTrace");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
  
}