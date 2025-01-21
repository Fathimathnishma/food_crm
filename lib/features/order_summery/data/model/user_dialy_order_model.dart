// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDialyOrderModel {
  String name;
  num qty;
  num splitAmount;
  Timestamp createdAt;
  UserDialyOrderModel({
    required this.name,
    required this.qty,
    required this.splitAmount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'qty': qty,
      'splitAmount': splitAmount,
      'createdAt': createdAt,
    };
  }

  factory UserDialyOrderModel.fromMap(Map<String, dynamic> map) {
    return UserDialyOrderModel(
      name: map['name'] as String,
      qty: map['qty'] as num,
      splitAmount: map['splitAmount'] as num,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDialyOrderModel.fromJson(String source) => UserDialyOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
