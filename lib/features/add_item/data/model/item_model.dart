// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ItemUploadingModel {
  String id;
  TextEditingController name;
  TextEditingController quantity;
  TextEditingController price;
  List<UserItemQtyAloccatedModel> users;
  ItemUploadingModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.users,
  });

  

  ItemUploadingModel copyWith({
    String? id,
    TextEditingController? name,
    TextEditingController? quantity,
    TextEditingController? price,
    num ?totalAmount ,
    List<UserItemQtyAloccatedModel>? users,
  }) {
    return ItemUploadingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      
      users: users ?? this.users,
    );
  }

}

class UserItemQtyAloccatedModel {
  String name;
  String phoneNumber;
  String id;
  num total;
  num splitAmount;
  TextEditingController qtyController;
  UserItemQtyAloccatedModel({
    required this.name,
    required this.phoneNumber,
    required this.id,
    required this.total,
    required this.splitAmount,
    required this.qtyController,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'id': id,
      'total': total,
      'splitAmount': splitAmount,
      'qtyController': qtyController,
    };
  }

  factory UserItemQtyAloccatedModel.fromMap(Map<String, dynamic> map) {
    return UserItemQtyAloccatedModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      id: map['id'] as String,
      total: map['total'] as num,
      splitAmount: map['splitAmount'] as num,
      qtyController: map['qtyController'] as TextEditingController,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserItemQtyAloccatedModel.fromJson(String source) => UserItemQtyAloccatedModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
