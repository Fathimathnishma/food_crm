// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:food_crm/features/add_item/data/model/user_item_qty_aloccated_model.dart';

// class ItemModel {
//   String id; 
//   String item;
//   num quantity;
//   num price;
//   num rate;
//   num splitAmount;
//   List<UserItemQtyAloccatedModel> users;

//   ItemModel({
//     required this.id,
//     required this.item,
//     required this.quantity,
//     required this.price,
//     required this.rate,
//     this.splitAmount = 0, 
//     required this.users,
//   });

//   ItemModel copyWith({
//     String? id,
//     String? item,
//     num? quantity,
//     num? price,
//     num? rate,
//     num? splitAmount,
//     List<UserItemQtyAloccatedModel>? users,
//   }) {
//     return ItemModel(
//       id: id ?? this.id,
//       item: item ?? this.item,
//       quantity: quantity ?? this.quantity,
//       price: price ?? this.price,
//       rate: rate ?? this.rate,
//       splitAmount: splitAmount ?? this.splitAmount, 
//       users: users ?? this.users,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'item': item,
//       'quantity': quantity,
//       'price': price,
//       'rate': rate,
//       'splitAmount': splitAmount,
//       'users': users.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ItemModel.fromMap(Map<String, dynamic> map) {
//     return ItemModel(
//       id: map['id'] as String,
//       item: map['item'] as String,
//       quantity: map['quantity'] as num,
//       price: map['price'] as num,
//       rate: map['rate'] as num,
//       splitAmount: map['splitAmount'] as num,
//       users: List<UserItemQtyAloccatedModel>.from((map['users'] as List<int>).map<UserItemQtyAloccatedModel>((x) => UserItemQtyAloccatedModel.fromMap(x as Map<String,dynamic>),),),
//     );
//   }



//   String toJson() => json.encode(toMap());

//   factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }



import 'package:flutter/material.dart';

class AddItemModel {
  String id; 
  TextEditingController name;
  TextEditingController quantity;
  TextEditingController price;
  AddItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  AddItemModel copyWith({
    String? id,
    TextEditingController? name,
    TextEditingController? quantity,
    TextEditingController? price,
  }) {
    return AddItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}




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

  UserItemQtyAloccatedModel copyWith({
    String? name,
    String? phoneNumber,
    String? id,
    TextEditingController? qtyController,
  }) {
    return UserItemQtyAloccatedModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      id: id ?? this.id,
      qtyController: qtyController ?? this.qtyController,
    );
  }
}
