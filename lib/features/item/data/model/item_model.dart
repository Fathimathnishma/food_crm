// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class ItemModel {
 String? id; 
  String item;
  num quantity;
  num price;
  num rate;
  ItemModel({
    this.id,
    required this.item,
    required this.quantity,
    required this.price,
    required  this.rate,
  });
  

  ItemModel copyWith({
    String? id,
    String? item,
    num? quantity,
    num? price,
    num? rate,
  }) {
    return ItemModel(
      id: id ?? this.id,
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': item,
      'quantity': quantity,
      'price': price,
      'rate': rate,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] != null ? map['id'] as String : null,
      item: map['item'] as String,
      quantity: map['quantity'] as num,
      price: map['price'] as num,
      rate:  map['rate'] as num ,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
