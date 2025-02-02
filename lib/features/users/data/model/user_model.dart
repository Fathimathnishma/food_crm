// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String phoneNumber;
  String name;
  String? id;
  num monthlyTotal;
  Timestamp createdAt;
  UserModel({
    required this.phoneNumber,
    required this.name,
    this.id,
    required this.monthlyTotal,
    required this.createdAt,
  });
 
  

  UserModel copyWith({
    String? phoneNumber,
    String? name,
    String? id,
    num? monthlyTotal,
    Timestamp? createdAt,
  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      id: id ?? this.id,
      monthlyTotal: monthlyTotal ?? this.monthlyTotal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'name': name,
      'id': id,
      'monthlyTotal': monthlyTotal,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      monthlyTotal: map['monthlyTotal'] as num,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
