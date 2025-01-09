

import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';

class OrderItemDeleteRowWidget extends StatelessWidget {
  final String itemName;
  final int quantity;
  final double ratePerItem;
  final VoidCallback onDelete;

  const OrderItemDeleteRowWidget({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.ratePerItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset('assets/images/check-list.png', height: 24, width: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              itemName,
              style: const TextStyle(
                  color: ClrConstant.whiteColor,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              ratePerItem.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 15,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.close,
                size: 24,
                color: ClrConstant.whiteColor,
              ),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
