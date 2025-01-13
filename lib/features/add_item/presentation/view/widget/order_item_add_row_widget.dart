import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/general/utils/color_const.dart';

class OrderItemAddRowWidget extends StatelessWidget {
  final AddItemModel addItem;
  final VoidCallback onAdd;
  final VoidCallback onDelete;
  final bool isAdd;

  const OrderItemAddRowWidget(
      {super.key,
      required this.onAdd,
      required this.addItem,
      required this.onDelete,
      required this.isAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: addItem.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/check-list.png',
                  height: 24,
                  width: 24,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                hintText: 'Item Name',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: TextField(
              controller: addItem.quantity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ClrConstant.whiteColor,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                hintText: 'Qty',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextField(
              controller: addItem.price,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ClrConstant.whiteColor,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                hintText: 'Rate per one',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor:isAdd?  const Color(0XFF1FAF38) :Colors.red,
            radius: 15,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon:  Icon(
               isAdd?Icons.add : Icons.close,
                color: ClrConstant.whiteColor,
                size: 24,
              ),
              onPressed:isAdd  ?onAdd : onDelete
            ),
          ),
        ],
      ),
    );
  }
}
