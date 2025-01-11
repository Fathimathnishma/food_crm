import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_card.dart';

class AmountBottomSheet extends StatelessWidget {
  const AmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 428,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Label 1',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Label 1',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Text(
                'Label 2',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return const OrderCard(
                    itemName: "akdms",
                    quantity: "dcs",
                    rate: "sxs",
                    listCount: 4);
              },
            ),
          ),
        ],
      ),
    );
  }
}
