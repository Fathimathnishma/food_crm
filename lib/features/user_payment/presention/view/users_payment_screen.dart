import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/presention/user_payment_provider/user_payment_provider.dart';
import 'package:food_crm/features/user_payment/presention/view/users_payment_history.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:food_crm/general/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UsersPaymentScreen extends StatefulWidget {
  final num total;
  const UsersPaymentScreen({super.key, required this.total});

  @override
  State<UsersPaymentScreen> createState() => _UsersPaymentScreenState();
}

class _UsersPaymentScreenState extends State<UsersPaymentScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider =
        Provider.of<UserPaymentProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.clearData();
      userProvider.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPaymentProvider>(
      builder: (context, userPro, child) {
        log(widget.total.toString());
        if (userPro.isLoading ) {
         return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        }
        if (userPro.isLoading && userPro.users.isEmpty) {
          return const Center(
            child: Text(
              "no users",
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                )),
            title: const Text(
              "Total Amount",
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
          body: ListView.separated(
            itemCount: userPro.users.length,
            itemBuilder: (context, index) {
              final user = userPro.users[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserpaymentHistory(
                                userId: user.id!,
                                userName: user.name,
                                total: user.monthlyTotal.toStringAsFixed(0),
                              )));
                },
                child: ListTile(
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Total",
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text(("₹${user.monthlyTotal.toStringAsFixed(0)}"),
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.whiteColor)),
                    ],
                  ),
                  leading:  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.whiteColor,
                     child: Text(userPro.getInitials(user.name),style:const TextStyle(color :AppColors.blackColor,fontSize: 20) ,),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 17, color: AppColors.whiteColor),
                  ),
                  subtitle: Text(
                    user.phoneNumber,
                    style: const TextStyle(color: AppColors.greyColor),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey.shade600,
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: CustomButton(
              onTap:  widget.total > 0
                  ? () async {
                      log("Total: ${widget.total.toString()}");
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialogWidget(
                            label1: "Mark as Paid",
                            label2: "Yes",
                            onLabel2Tap: () async {
                              await userPro.markPayment(paidAmount: widget.total);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
              }:null,
              buttontext: "Mark As Paid",
              color: widget.total > 0 ? Colors.blueAccent : AppColors.greyColor,
              textColor: AppColors.whiteColor,
            ),
          ),
        );
      },
    );
  }
}
