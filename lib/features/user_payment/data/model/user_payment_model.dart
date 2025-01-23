import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';

class OrderDailyReportModel {
  Timestamp? createdAt;
  List<UserDialyOrderModel>? items;

  OrderDailyReportModel({
    this.createdAt,
    this.items,
  });

  factory OrderDailyReportModel.fromMap(Map<String, dynamic> map) {
    final itemsMap = map['item'] as Map<String, dynamic>? ?? {};

    final List<UserDialyOrderModel> itemList = itemsMap.entries.map((entry) {
      final itemData = entry.value as Map<String, dynamic>?;

      if (itemData == null) {
        return null;
      }

      return UserDialyOrderModel.fromMap(itemData);
    }).whereType<UserDialyOrderModel>().toList(); 

    return OrderDailyReportModel(
      createdAt: map['createdAt'] as Timestamp?,
      items: itemList,
    );
  }
}
