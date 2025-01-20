// // ignore_for_file: public_member_api_docs, sort_constructors_first


// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:food_crm/features/add_item/data/model/item_model.dart';

// class OrderModel {
// String? id;
// Timestamp createdAt;
// num totalAmount;
// List<ItemUploadingModel> order;
//   OrderModel({
//     this.id,
//     required this.createdAt,
//     required this.totalAmount,
//     required this.order,
//   });
  
//   OrderModel copyWith({
//     String? id,
//     Timestamp? createdAt,
//     num? totalAmount,
//     List<ItemUploadingModel>? order,
//   }) {
//     return OrderModel(
//       id: id ?? this.id,
//       createdAt: createdAt ?? this.createdAt,
//       totalAmount: totalAmount ?? this.totalAmount,
//       order: order ?? this.order,
//     );
//   }
//  }



// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';

class OrderModel {
  final String? id;
  final Timestamp createdAt;
  final num totalAmount;
  final List<ItemUploadingModel> order;

  OrderModel({
    this.id,
    required this.createdAt,
    required this.totalAmount,
    required this.order,
  });

  OrderModel copyWith({
    String? id,
    Timestamp? createdAt,
    num? totalAmount,
    List<ItemUploadingModel>? order,
  }) {
    return OrderModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      totalAmount: totalAmount ?? this.totalAmount,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,  // Timestamp is already Firebase-compatible
      'totalAmount': totalAmount,
      'order': order.toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['createdAt'] as Timestamp,  // Directly cast to Timestamp
      totalAmount: map['totalAmount'] as num,
      order: List<ItemUploadingModel>.from(
        (map['order'] as List)
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => 
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
