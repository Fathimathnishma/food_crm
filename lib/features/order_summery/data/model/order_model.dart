// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';

class OrderModel {
  String? id;
  Timestamp createdAt;
  num totalAmount;
 List<ItemUploadingModel> order;  // Changed from Map to List
  OrderModel({
    this.id,
    required this.createdAt,
    required this.totalAmount,
    required this.order,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'totalAmount': totalAmount,
      'order': order.map((x) => x.toMap()).toList(),
    };
  }



factory OrderModel.fromMap(Map<String, dynamic> map) {
  List<ItemUploadingModel> orderItems = [];

  // Ensure 'order' is a Map of items, not a List
  if (map['order'] is Map<String, dynamic>) {
    (map['order'] as Map<String, dynamic>).forEach((key, value) {
      // Handle each item inside the order map
      orderItems.add(ItemUploadingModel.fromMap(value as Map<String, dynamic>));
    });
  }

  return OrderModel(
    id: map['id'] as String? ?? "", 
    createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(), 
    totalAmount: map['totalAmount'] as num? ?? 0, 
    order: orderItems,
  );
}





  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
