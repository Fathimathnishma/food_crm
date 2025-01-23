// import 'package:flutter/material.dart';
// import 'package:food_crm/features/user_payment/presention/user_payment_provider/user_payment_provider.dart';
// import 'package:food_crm/features/user_payment/presention/view/widgets/amount_bottomsheet.dart';
// import 'package:food_crm/features/user_payment/presention/view/widgets/total_card.dart';
// import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
// import 'package:food_crm/general/utils/app_colors.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class UserpaymentHistory extends StatefulWidget {
//   final String userId;
//   const UserpaymentHistory({super.key, required this.userId});

//   @override
//   State<UserpaymentHistory> createState() => _UserpaymentHistoryState();
// }

// class _UserpaymentHistoryState extends State<UserpaymentHistory> {
//   @override
//   void initState() {
//     super.initState();
//     final userPaymentProvider =
//         Provider.of<UserPaymentProvider>(context, listen: false);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       userPaymentProvider.fetchUserPayment(userId: widget.userId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.blackColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.blackColor,
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back_ios_new,
//               color: AppColors.whiteColor,
//             )),
//         title: const Text(
//           "Name",
//           style: TextStyle(color: AppColors.whiteColor),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.primaryColor,
//         child: const Icon(
//           Icons.add,
//           size: 40,
//         ),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const AddUserScreen(),
//               ));
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const TotalCardWidget(subtitle: "124"),
//             Expanded(
//               child: Consumer<UserPaymentProvider>(
//                 builder: (context, userPaymentPro, child) {
//                   final userPayment = userPaymentPro.userPaymentList;

//                   final dateTime = userPayment!.createdAt.toDate();
//                   // Format date
//                   final formattedDate =
//                       DateFormat('yyyy-MM-dd').format(dateTime);
//                   // Format day
//                   final day = DateFormat('EEEE').format(dateTime);
//                   return InkWell(
//                     onTap: () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const UserpaymentHistory(),));
//                     },
//                     child: InkWell(
//                       onTap: () {
//                         showBottomSheet(
//                           context: context,
//                           builder: (context) {
//                             return const AmountBottomSheet();
//                           },
//                         );
//                       },
//                       child: ListTile(
//                         trailing: Text(userPayment.splitAmount.toString(),
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.whiteColor,
//                                 fontWeight: FontWeight.w400)),
//                         title: Text(
//                           formattedDate,
//                           style: const TextStyle(
//                               fontSize: 17,
//                               color: AppColors.whiteColor,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         subtitle: Text(
//                           day,
//                           style: const TextStyle(
//                               color: AppColors.greyColor,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/presention/user_payment_provider/user_payment_provider.dart';
import 'package:food_crm/features/user_payment/presention/view/widgets/amount_bottomsheet.dart';
import 'package:food_crm/features/user_payment/presention/view/widgets/total_card.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserpaymentHistory extends StatefulWidget {
  final String userId;
  const UserpaymentHistory({super.key, required this.userId});

  @override
  State<UserpaymentHistory> createState() => _UserpaymentHistoryState();
}

class _UserpaymentHistoryState extends State<UserpaymentHistory> {
  @override
  void initState() {
    super.initState();
    final userPaymentProvider =
        Provider.of<UserPaymentProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userPaymentProvider.fetchUserPayment(userId: widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        title: const Text(
          "Name",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserScreen(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TotalCardWidget(subtitle: "124"),
            Expanded(
              child: Consumer<UserPaymentProvider>(
                builder: (context, userPaymentPro, child) {
                  final userPayment = userPaymentPro.userPayment;

                  // Ensure userPayment is not null
                  if (userPayment == null) {
                    return const Center(
                      child: Text(
                        "No payment history available",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  final dateTime = userPayment.createdAt.toDate();
                  // Format date
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(dateTime);
                  // Format day
                  final day = DateFormat('EEEE').format(dateTime);

                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const UserpaymentHistory(),));
                    },
                    child: InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return const AmountBottomSheet();
                          },
                        );
                      },
                      child: ListTile(
                        trailing: Text(
                          userPayment.splitAmount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        title: Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 17,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          day,
                          style: const TextStyle(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



