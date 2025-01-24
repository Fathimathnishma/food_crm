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
  final String userName;
  final String total;
  const UserpaymentHistory(
      {super.key,
      required this.userId,
      required this.userName,
      required this.total});

  @override
  State<UserpaymentHistory> createState() => _UserpaymentHistoryState();
}

class _UserpaymentHistoryState extends State<UserpaymentHistory> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final userPaymentProvider =
        Provider.of<UserPaymentProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userPaymentProvider.fetchUserPayment(userId: widget.userId);
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!userPaymentProvider.isLoading && !userPaymentProvider.noMoreData) {
          userPaymentProvider.fetchUserPayment(userId: widget.userId);
        }
      }
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
            )),
        title: Text(
          widget.userName,
          style: const TextStyle(color: AppColors.whiteColor),
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
              ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TotalCardWidget(subtitle: widget.total),
            Expanded(
              child: Consumer<UserPaymentProvider>(
                builder: (context, userPaymentPro, child) {
                  if (userPaymentPro.isLoading &&
                      userPaymentPro.userOrder.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (userPaymentPro.userOrder.isEmpty) {
                    return const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      controller: scrollController,
                      itemCount: userPaymentPro.userOrder.length,
                      itemBuilder: (context, index) {
                        final userPayment = userPaymentPro.userOrder[index];

                        final dateTime = userPayment.createdAt!.toDate();

                        // Format date
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(dateTime);
                        //  Format day
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
                                  return AmountBottomSheet(
                                    order: userPayment.items!,
                                    day: day,
                                    date: formattedDate,
                                    total: userPaymentPro
                                        .getTotalForOrder(userPayment)
                                        .toString(),
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              trailing: Text(
                                  userPaymentPro
                                      .getTotalForOrder(userPayment)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400)),
                              title: Text(
                                formattedDate,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                day,
                                style: const TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.shade600,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
