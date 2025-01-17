// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:food_crm/features/add_item/data/model/item_model.dart';

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
 }
