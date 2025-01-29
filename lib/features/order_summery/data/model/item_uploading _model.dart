
import 'package:food_crm/features/add_item/data/model/item_model.dart';

class ItemUploadingModel {
  String name;
  num price;
  num qty;
 
  List<UserItemQtyAloccatedModel> users;

  ItemUploadingModel({
    required this.name,
    required this.price,
    required this.qty,
    
    this.users = const [], // Default to an empty list
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'qty': qty,
      
      // Only include users if they are populated
      if (users.isNotEmpty) 'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemUploadingModel.fromMap(Map<String, dynamic> map, {bool includeUsers = false}) {
  return ItemUploadingModel(
    name: map['name'] as String? ?? '',
    price: map['price'] as num? ?? 0,
    qty: map['qty'] as num? ?? 0,
    
    users: includeUsers && map.containsKey('users') && map['users'] is Map<String, dynamic>
        ? (map['users'] as Map<String, dynamic>).entries.map<UserItemQtyAloccatedModel>(
            (userEntry) => UserItemQtyAloccatedModel.fromMap(userEntry.value as Map<String, dynamic>),
          ).toList()
        : [], // Default to an empty list if users are not included
  );
}

  
}
