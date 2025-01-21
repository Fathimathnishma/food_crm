// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';

class OrderModel {
  String? id;
  Timestamp createdAt;
  num totalAmount;
  List<ItemUploadingModel> order;

  OrderModel({
    this.id,
    required this.createdAt,
    required this.totalAmount,
    required this.order,
  });

  // This will be used for adding orders
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'totalAmount': totalAmount,
      'order': order.map((x) => x.toMap()).toList(),
    };
  }
factory OrderModel.fromMap(Map<String, dynamic> map) {
  return OrderModel(
    id: map['id'] != null ? map['id'] as String : null,
    createdAt: map['createdAt'] as Timestamp,
    totalAmount: map['totalAmount'] as num,
    order: (map['order'] is Map<String, dynamic>)
        ? List<ItemUploadingModel>.from(
            (map['order'] as Map<String, dynamic>).entries.map<ItemUploadingModel>(
              (entry) => ItemUploadingModel.fromMap(entry.value as Map<String, dynamic>, includeUsers: false),
            ),
          )
        : [], 
  );
}


  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
