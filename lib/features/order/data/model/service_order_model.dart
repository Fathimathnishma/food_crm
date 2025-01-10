// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceOrderModel {
  String? id;
  Timestamp createdAt;
  List<Map<String, dynamic>> orders;
  ServiceOrderModel({
    this.id,
    required this.createdAt,
    required this.orders,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'orders': orders,
    };
  }

   factory ServiceOrderModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['createdAt'] as Timestamp,
      orders: List<Map<String, dynamic>>.from(
          (map['orders'] as List).map((order) => order as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrderModel.fromJson(String source) => ServiceOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ServiceOrderModel copyWith({
    String? id,
    Timestamp? createdAt,
    List<Map<String, dynamic>>? orders,
  }) {
    return ServiceOrderModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      orders: orders ?? this.orders,
    );
  }
}
