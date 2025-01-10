import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class UserRowWidget extends StatelessWidget {
 
  final String name;
  final num qty;
  final num amount;
  const UserRowWidget({
    super.key,
    required this.name,
    required this.qty,
    required this.amount,
    
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, stateUderAdd, child) {
        return ListTile(
          leading: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialogWidget(
                          label1: 'delete user',
                          label2: 'delete',
                          onLabel2Tap: () {
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
                const SizedBox(
                  width: 3,
                ),
                CircleAvatar(
                  radius: 23,
                  backgroundColor: ClrConstant.whiteColor,
                  child: Text(
                    stateUderAdd.getInitials(name),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontSize: 17, color: ClrConstant.whiteColor),
          ),
          trailing: SizedBox(
            width: 80,
            child: Row(
              children: [
                Text(
                  qty.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '₹${amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
