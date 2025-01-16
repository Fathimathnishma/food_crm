import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class UserRowWidget extends StatelessWidget {
  final String name;
  final num qty;
  final num amount;
  final int index;
  final int tabIndex;
  final TextEditingController
      controller; 
  final Function(int, int)
      onDelete; 

  const UserRowWidget({
    super.key,
    required this.name,
    required this.qty,
    required this.amount,
    required this.index, 
    required this.tabIndex, 
    required this.onDelete,
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, stateUserAdd, child) {
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
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.whiteColor,
                  child: Text(
                    stateUserAdd
                        .getInitials(name), // Display the initials of the name
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
            style: const TextStyle(fontSize: 17, color: AppColors.whiteColor),
          ),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 33,
                  child: TextFormField(
        
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "qty",
                        hintStyle: TextStyle(color: AppColors.whiteColor)),
                    style: const TextStyle(color: Colors.white),
        
                  ),
                ),
                
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
