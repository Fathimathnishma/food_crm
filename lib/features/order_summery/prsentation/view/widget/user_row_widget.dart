import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/order_summery/prsentation/provider/order_summery_provider.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class UserRowWidget extends StatelessWidget {
  final String name;
  final String price;
  final int index;
  final int tabIndex;
  final TextEditingController controller;
  final Function(int, int) onDelete;

  const UserRowWidget({
    super.key,
    required this.name,
    required this.price,
    required this.index,
    required this.tabIndex,
    required this.onDelete,
    required this.controller,
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
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogWidget(
                      label1: 'Delete User',
                      label2: 'Delete',
                      onLabel2Tap: () async {
                        onDelete(tabIndex, index);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(width: 2),
            Consumer<UserProvider>(
              builder: (context, stateUserAdd, child) => CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.whiteColor,
                child: Text(
                  stateUserAdd
                      .getInitials(name), 
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
            width: MediaQuery.of(context).size.width * 0.34,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: controller,
                    onChanged:(value) async {
                final newQty = num.tryParse(value);
                if (newQty == null || newQty <= 0) {
                 
                  return;
                } else{
                 log("Valid quantity entered: $newQty");
                 final formattedQty = newQty == newQty 
                    ? newQty.toStringAsFixed(0) 
                    : newQty.toStringAsFixed(0);

                 controller.text = formattedQty;
                 stateAddOrder.checkQty(tabIndex: tabIndex);
                }
                  stateAddOrder.updateSplitAmount(tabIndex: tabIndex, price: price);
              },
                    decoration: const InputDecoration(
                      hintText: "qty",
                      hintStyle: TextStyle(color: AppColors.whiteColor),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Consumer<OrderSummeryProvider>(
                  builder: (context, stateAddOrder, child) {
                    final amount = stateAddOrder
                        .itemsList[tabIndex].users[index].splitAmount;
                    return Text(
                      '₹${amount.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white,fontSize: 14),
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
