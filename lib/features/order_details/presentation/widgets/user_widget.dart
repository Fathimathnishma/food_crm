
import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/prsentation/provider/order_summery_provider.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget {
  final String name;
  final String price;
  final int index;
  final int tabIndex;

  const UserWidget({
    super.key,
    required this.name,
    required this.price,
    required this.index,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 2),
            Consumer<UserProvider>(
              builder: (context, stateUserAdd, child) => CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.whiteColor,
                child: Text(
                  stateUserAdd
                      .getInitials(name), // Display initials of the name
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 17, color: AppColors.whiteColor),
      ),
      trailing: Consumer<OrderSummeryProvider>(
        builder: (context, stateAddOrder, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40, child: Text('data')),
                Consumer<OrderSummeryProvider>(
                  builder: (context, stateAddOrder, child) {
                    final amount = stateAddOrder
                        .itemsList[tabIndex].users[index].splitAmount;
                    return Text(
                      '₹${amount.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
