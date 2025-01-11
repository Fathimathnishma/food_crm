import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/item_provider.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:provider/provider.dart';

class OrderItemAddRowWidget extends StatelessWidget {

  final VoidCallback onAdd;

  const OrderItemAddRowWidget(
      {super.key,
      required this.onAdd,
      });

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: itemProvider.itemController,
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
          SizedBox(
            width: 50,
            child: TextField(
              controller: itemProvider.totalQuantityController,
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
          SizedBox(
            width: 80,
            child: TextField(
              controller: itemProvider.priceController,
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
          CircleAvatar(
            backgroundColor: const Color(0XFF1FAF38),
            radius: 15,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add,
                color: ClrConstant.whiteColor,
                size: 24,
              ),
              onPressed: onAdd,
            ),
          ),
        ],
      ),
    );
  }
}
