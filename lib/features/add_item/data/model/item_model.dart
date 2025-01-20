// ignore_for_file: public_member_api_docs, sort_constructors_first
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
 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.text, 
      'quantity': quantity.text,
      'price': price.text,
      'users': users.map((x) => x.toMap()).toList(), 
    };
  }

  factory ItemUploadingModel.fromMap(Map<String, dynamic> map) {
    return ItemUploadingModel(
      id: map['id'] as String,
      name: TextEditingController(text: map['name'] as String),
      quantity: TextEditingController(text: map['quantity'] as String),
      price: TextEditingController(text: map['price'] as String),
      users: List<UserItemQtyAloccatedModel>.from(
        (map['users'] as List<dynamic>).map(
          (x) => UserItemQtyAloccatedModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }




}

class UserItemQtyAloccatedModel {
  String name;
  String phoneNumber;
  String id;
 
  num splitAmount;
  TextEditingController qtyController;

  UserItemQtyAloccatedModel({
    required this.name,
    required this.phoneNumber,
    required this.id,
    required this.splitAmount,
    required this.qtyController,
  });

  // Convert UserItemQtyAloccatedModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'id': id,
      'splitAmount': splitAmount,
      'qtyController': qtyController.text,  // Store the text value of qtyController
    };
  }

  // Convert Map to UserItemQtyAloccatedModel
  factory UserItemQtyAloccatedModel.fromMap(Map<String, dynamic> map) {
    return UserItemQtyAloccatedModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      id: map['id'] as String,
      splitAmount: map['splitAmount'] as num,
      qtyController: TextEditingController(text: map['qtyController'] as String),  // Initialize with text value
    );
  }
}
