// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:cloud_firestore/cloud_firestore.dart';

// class OrderDailyReportModel {
//   Timestamp? createdAt;
//   List<UserDialyOrderModel>? items;
//   OrderDailyReportModel({
//     this.createdAt,
//     this.items,
//   });

//   OrderDailyReportModel copyWith({
//     Timestamp? createdAt,
//     List<UserDialyOrderModel>? items,
//   }) {
//     return OrderDailyReportModel(
//       createdAt: createdAt ?? this.createdAt,
//       items: items ?? this.items,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'createdAt': createdAt,
//       'items': items,
//     };
//   }

//   factory OrderDailyReportModel.fromMap(Map<String, dynamic> map) {
//     return OrderDailyReportModel(
//       createdAt: map['createdAt'] as Timestamp?,
//       items: map['items'] != null
//           ? List<UserDialyOrderModel>.from(
//               (map['items'] as List<int>).map<UserDialyOrderModel?>(
//                 (x) => UserDialyOrderModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//     );
//   }

//   static List<UserDialyOrderModel> mapConvertToList(
//       Map<String, dynamic> itemMap) {
//     List<UserDialyOrderModel> item = [];
//     itemMap.forEach(
//       (key, value) {
//         item.add(UserDialyOrderModel.fromMap(value));
//       },
//     );
//     return item;
//   }
// }
// ignore_for_file: public_member_api_docs, sort_constructors_first


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

