import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/order_history/data/model/i_order_history_facade.dart';
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
  Future<Either<MainFailures, List<OrderModel>>> fetchOrderList() async {
    try {
      final orderRef = firebaseFirestore.collection(FirebaseCollection.order).orderBy("createdAt");
      Query query = lastDocument == null ? orderRef.limit(15) : orderRef.startAfterDocument(lastDocument!).limit(15);
      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        noMoreData = true;
        return right([]); 
      }

      lastDocument = snapshot.docs.last;

      final orders = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        List<ItemUploadingModel> orderItems = [];
        (data['order'] as List).forEach((item) {
          orderItems.add(
             
            ItemUploadingModel(
              id: item['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
              name: TextEditingController(text: item['name']),
              quantity:TextEditingController(text: item['quantity']),
              price:TextEditingController(text: item['price']),
              users: [],  
            ),
          );
        });
        // Return the populated OrderModel
        return OrderModel(
          id: data['id'] as String?,
          createdAt: data['createdAt'] as Timestamp,
          totalAmount: data['totalAmount'] as num,
          order: orderItems,
        );
      }).toList();
      return right(orders);
    } catch (e) {
      // Log the error
      log("Error fetching order list: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}
