// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class UserItemQtyAloccatedModel {
  String name;
  String phoneNumber;
  String id;
  TextEditingController qtyController;
  UserItemQtyAloccatedModel({
    required this.name,
    required this.phoneNumber,
    required this.id,
    required this.qtyController,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'id': id,
      'qtyController': qtyController,
    };
  }

  factory UserItemQtyAloccatedModel.fromMap(Map<String, dynamic> map) {
    return UserItemQtyAloccatedModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      id: map['id'] as String,
      qtyController: map['qtyController'] as TextEditingController,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserItemQtyAloccatedModel.fromJson(String source) => UserItemQtyAloccatedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
