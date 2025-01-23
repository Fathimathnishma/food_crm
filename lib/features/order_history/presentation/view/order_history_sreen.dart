import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/presentation/provider/order_history_provider.dart';
import 'package:food_crm/features/order_history/presentation/view/widgets/order_card.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    final historyProvider = Provider.of<OrderHistoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
     historyProvider.fetchOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.blackColor,
        title: const Text(
          "History",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, stateFetchOrder, child) {

          // final today =  NtpTimeSyncChecker.getNetworkTime() ?? DateTime.now();
          // final formattedDate = DateFormat('yyyy-MM-dd').format(today);

          // Check if the orders list is empty
          if (stateFetchOrder.allOrders.isEmpty) {
            return const Center(
              child: Text(
                "No orders available",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              ),
            );
          }
           if (stateFetchOrder.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Showing Results: All",
                  style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: stateFetchOrder.allOrders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = stateFetchOrder.allOrders[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                   stateFetchOrder.formatCreatedAt(order.createdAt) ,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    "₹${order.totalAmount}",
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          OrderCard(
                            items: order.order,
                            total: order.totalAmount.toString(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
