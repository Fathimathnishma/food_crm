import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/presentation/view/widgets/order_card.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';

class AmountBottomSheet extends StatelessWidget {
  final List<UserDialyOrderModel> order;
  final String day;
  final String date;
  final String total;

  const AmountBottomSheet({
    super.key,
    required this.order,
    required this.day,
    required this.date, required this.total,
  });

  @override
  Widget build(BuildContext context) {
    // Filter orders into categories
    final breakfast = order.where((item) => item.foodTime == "breakfast").toList();
    final lunch = order.where((item) => item.foodTime == "lunch").toList();
    final dinner = order.where((item) => item.foodTime == "dinner").toList();
     String calculateTotal(List<UserDialyOrderModel> items) {
    final total = items.fold<num>(
      0,
      ( sum, item) => sum + (item.splitAmount ),
    );
    return total.toString();
  }

    return Container(
      height: 428,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Day and Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
               Text(
                total,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 2),
          const SizedBox(height: 10),
          // Order List
          Expanded(
            child: ListView(
              children: [
                if (breakfast.isNotEmpty)
                  OrderCard(items: breakfast, total: calculateTotal(breakfast)),
                  const SizedBox(height: 10,),
                if (lunch.isNotEmpty)
                  OrderCard(items: lunch, total: calculateTotal(lunch)),
                   const SizedBox(height: 10,),
                if (dinner.isNotEmpty)
                  OrderCard(items: dinner, total: calculateTotal(dinner)),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

 // Utility function to calculate total
 
}
