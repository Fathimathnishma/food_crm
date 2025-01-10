// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
 String? id; 
  String item;
  num quantity;
  num price;
  Timestamp createdAt;
  OrderModel({
    this.id,
    required this.item,
    required this.quantity,
    required this.price,
    required this.createdAt,
  });

   

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': item,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      item: map['item'] as String,
      quantity: map['quantity'] as num,
      price: map['price'] as num,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderModel copyWith({
    String? id,
    String? item,
    num? quantity,
    num? price,
    Timestamp? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
