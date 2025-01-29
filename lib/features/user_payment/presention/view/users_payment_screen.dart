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
                  leading: const CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.whiteColor,
                    // child: Text(userPro.getInitials(user.name)),
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
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      label1: "mark as paid",
                      label2: "yes",
                      onLabel2Tap: () async {
                        await userPro.markPayment();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              buttontext: "Mark As Paid",
              color: Colors.blueAccent,
              textColor: AppColors.whiteColor,
            ),
          ),
        );
      },
    );
  }
}
