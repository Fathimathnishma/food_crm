// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';


class OrderModel {
  String? id;
  Timestamp createdAt;
  num totalAmount;
  List<ItemUploadingModel> order; // Changed from Map to List

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

    // Ensure 'order' is a Map of items
    if (map['order'] is Map<String, dynamic>) {
      (map['order'] as Map<String, dynamic>).forEach((key, value) {
        if (value != null && value is Map<String, dynamic>) {
          // Safely parse each item inside the order map
          orderItems.add(ItemUploadingModel.fromMap(value));
        } else {
          // Log invalid or null entries for debugging
          print("Invalid or null order item: $key -> $value");
        }
      });
    } else {
      print("'order' field is missing or invalid: ${map['order']}");
    }

    return OrderModel(
      id: map['id'] as String? ?? "unknown_id", // Use a meaningful fallback for ID
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(), // Default to current timestamp
      totalAmount: map['totalAmount'] as num? ?? 0, // Default to 0 if missing
      order: orderItems, // Parsed list of order items
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
