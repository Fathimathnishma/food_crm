import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class UserRowWidget extends StatelessWidget {
  final String name;
  final num qty;
  final num amount;
  final int index; // Index to identify the user
  final int tabIndex;
  // final TextEditingController controller;
  final Function(int,int) controller; // The tab index to know which tab the user belongs to
   final Function(int, int) onDelete; // Callback function to handle delete (with tabIndex)

  const UserRowWidget({
    super.key,
    required this.name,
    required this.qty,
    required this.amount,
    required this.index, // The index of the user in the list
    required this.tabIndex, // The tab index to know which tab
     required this.onDelete, 
     required this.controller, // The callback function to delete the user
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
                          label1: 'Delete User', // Show confirmation dialog
                          label2: 'Delete',
                          onLabel2Tap: () {
                             onDelete(tabIndex, index); 
                            Navigator.pop(context); // Close the dialog
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
                  backgroundColor: ClrConstant.whiteColor,
                  child: Text(
                    stateUserAdd.getInitials(name), // Display the initials of the name
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
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 33,
                  child: TextFormField(
                   controller:controller(tabIndex, index) ,
                   decoration: const InputDecoration(
                    hintText:"qty",
                    hintStyle: TextStyle(color: ClrConstant.whiteColor,fontSize: 13)
                   ),
                   style:const TextStyle(color: Colors.white), 
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
