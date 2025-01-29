import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class OrderCard extends StatelessWidget {
  final List<dynamic> items; // List of items in the order
  final String total;

  const OrderCard({
    super.key,
    required this.items,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item"),
                  Row(
                    children: [
                      Text("Qty"),
                      SizedBox(width: 20),
                      Text("Price"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Items
          ...items.map((item) {
            // Extract values whether they are strings or from a TextEditingController
            final itemName = item.name is TextEditingController
                ? item.name.text
                : item.name.toString();
            final itemQuantity = item.qty is TextEditingController
                ? item.qty.text
                : item.qty.toString();

            // Conditional check for item type
            String itemPrice = '';
            if (item is ItemUploadingModel) {
              // Use price if the item is of type ItemUploadingModel
              itemPrice = item.price.toString();
            } else if (item is UserDialyOrderModel) {
              // Use splitAmount if the item is of type UserDialyOrderModel
              itemPrice = item.splitAmount.toString();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(itemName),
                  Row(
                    children: [
                      Text(itemQuantity),
                      const SizedBox(width: 20),
                      Text("₹$itemPrice"), // Display the price or splitAmount
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          // Total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 60,
                      child: Divider(
                        height: 8,
                        thickness: 1.5,
                        color: AppColors.blackColor,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "₹$total",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
