import 'dart:convert';

import 'package:food_crm/features/add_item/data/model/item_model.dart';

class ItemUploadingModel {
  String name;
  num price;
  num qty;
  String foodTime;
  List<UserItemQtyAloccatedModel> users;

  ItemUploadingModel({
    required this.name,
    required this.price,
    required this.qty,
    required this.foodTime,
    this.users = const [], // Default to an empty list
  });

  factory ItemUploadingModel.fromJson(String source) =>
      ItemUploadingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'qty': qty,
      "foodTime":foodTime,
      // Only include users if they are populated
      if (users.isNotEmpty) 'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemUploadingModel.fromMap(Map<String, dynamic> map, {bool includeUsers = false}) {
    return ItemUploadingModel(
      name: map['name'] as String? ?? '', // Default to empty string
      price: map['price'] as num? ?? 0,  // Default to 0
      qty: map['qty'] as num? ?? 0,      // Default to 0
      users: includeUsers
          ? List<UserItemQtyAloccatedModel>.from(
              (map['users'] as List<dynamic>? ?? [])
                  .map((x) => UserItemQtyAloccatedModel.fromMap(x as Map<String, dynamic>)),
            )
          : [], foodTime: map["foodTime"] as String,
    );
  }

  
}
