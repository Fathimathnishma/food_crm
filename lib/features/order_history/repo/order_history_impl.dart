import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_history/data/model/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderHistoryFacade)
class OrderHistoryImpl implements IOrderHistoryFacade {
  final FirebaseFirestore firebaseFirestore;

  OrderHistoryImpl({required this.firebaseFirestore});

  bool noMoreData = false;
  DocumentSnapshot? lastDocument;
  


  @override
  @override
Future<Either<MainFailures, List<OrderModel>>> fetchOrderList() async {
  try {
    // Reference to the orders collection in Firestore
    final orderCollection = firebaseFirestore.collection(FirebaseCollection.order);

    // Query for orders. You can add limits, sorting, or filtering as needed
    final querySnapshot = await orderCollection.get();

    // If no orders are found, return an empty list
    if (querySnapshot.docs.isEmpty) {
      return right([]);
    }

    // Parse the order documents into a list of OrderModel
    List<OrderModel> orders = [];
    for (var doc in querySnapshot.docs) {
      final orderData = doc.data() as Map<String, dynamic>;

      // Log the fetched data for debugging purposes
      log("Fetched order data: $orderData");

      // Parse the order data
      List<ItemUploadingModel> orderItems = [];
      if (orderData['order'] is Map<String, dynamic>) {
        (orderData['order'] as Map<String, dynamic>).forEach((key, value) {
          orderItems.add(ItemUploadingModel.fromMap(value as Map<String, dynamic>));
        });
      }

      // Create the OrderModel from the fetched data
      final order = OrderModel(
        id: orderData['id'] as String,
        createdAt: orderData['createdAt'] as Timestamp,
        totalAmount: orderData['totalAmount'] as num,
        order: orderItems,
      );

      // Add the parsed order to the list
      orders.add(order);
    }

    // Return the list of orders wrapped in a successful result
    return right(orders);
  } catch (e) {
    // Log the error and return a failure result
    log("Error while fetching order list: $e");
    return left(MainFailures.serverFailures(errormsg: e.toString()));
  }
}


}
