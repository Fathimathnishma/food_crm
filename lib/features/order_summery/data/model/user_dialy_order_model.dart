// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDialyOrderModel {
  String name;
  num qty;
  num splitAmount;
  String? foodTime;
  UserDialyOrderModel({
    required this.name,
    required this.qty,
    required this.splitAmount,
     this.foodTime,
  });  

  UserDialyOrderModel copyWith({
    String? name,
    num? qty,
    num? splitAmount,
    String? foodTime,
  }) {
    return UserDialyOrderModel(
      name: name ?? this.name,
      qty: qty ?? this.qty,
      splitAmount: splitAmount ?? this.splitAmount,
      foodTime: foodTime ?? this.foodTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'qty': qty,
      'splitAmount': splitAmount,
      'foodTime': foodTime,
    };
  }

  factory UserDialyOrderModel.fromMap(Map<String, dynamic> map) {
    return UserDialyOrderModel(
      name: map['name'] as String,
      qty: map['qty'] as num,
      splitAmount: map['splitAmount'] as num,
      foodTime: map['foodTime'] != null ? map['foodTime'] as String : null,
    );
  }

  }
