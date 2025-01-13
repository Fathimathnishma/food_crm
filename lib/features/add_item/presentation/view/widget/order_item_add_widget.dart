// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class OrderItemAddWidget extends StatelessWidget {
  final ItemUploadingModel itemModel;
  final bool isAdd;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const OrderItemAddWidget({
    super.key,
    required this.itemModel,
    required this.isAdd,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: itemModel.name,
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
              controller: itemModel.quantity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.whiteColor,
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
              controller: itemModel.price,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                hintText: 'Rate per one',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 8),
          if (isAdd)
            CircleAvatar(
              backgroundColor: const Color(0XFF1FAF38),
              radius: 15,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 24,
                ),
                onPressed: onAdd,
              ),
            )
          else
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 15,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.whiteColor,
                  size: 24,
                ),
                onPressed: onRemove,
              ),
            )
        ],
      ),
    );
  }
}
