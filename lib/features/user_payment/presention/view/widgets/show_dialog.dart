import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/presentation/view/widgets/order_card.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';

class AmountShowDialog extends StatelessWidget {
  final List<UserDialyOrderModel> order;
  final String day;
  final String date;
  final String total;

  const AmountShowDialog({
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

    return Dialog(
       shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10), 
  ),
  child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 380,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                        SizedBox(
              height: 370,
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
            ),
          ),
         
          
        
    );
  }

 
}
