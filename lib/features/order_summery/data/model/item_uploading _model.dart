// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:food_crm/features/add_item/data/model/item_model.dart';

class ItemUploadingModel {
String id;
String name;
num price;
num qty;
List<UserItemQtyAloccatedModel> users;
  ItemUploadingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.users,
  });
 
  factory ItemUploadingModel.fromJson(String source) => ItemUploadingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'qty': qty,
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemUploadingModel.fromMap(Map<String, dynamic> map) {
    return ItemUploadingModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as num,
      qty: map['qty'] as num,
      users: List<UserItemQtyAloccatedModel>.from((map['users'] as List<int>).map<UserItemQtyAloccatedModel>((x) => UserItemQtyAloccatedModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());
}
