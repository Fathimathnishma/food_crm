import 'package:cloud_firestore/cloud_firestore.dart';

class UserPaymentModel {
  final DateTime createdAt;
  final List<dynamic> items;

  UserPaymentModel({required this.createdAt, required this.items});

  factory UserPaymentModel.fromMap(Map<String, dynamic> map) {
    return UserPaymentModel(
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      items: map['items'] as List<dynamic>,
    );
  }
}
