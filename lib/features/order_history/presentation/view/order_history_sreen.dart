import 'package:flutter/material.dart';
import 'package:food_crm/features/order_history/presentation/provider/order_history_provider.dart';
import 'package:food_crm/features/order_history/presentation/view/widgets/order_card.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
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
          final dateKeys = stateFetchOrder.groupedOrders.keys.toList();

          if (stateFetchOrder.allOrders.isEmpty) {
            return const Center(
              child: Text(
                "No orders available",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
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
                    shrinkWrap: true, 
                    itemCount: dateKeys.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final date = dateKeys[index];
                      final orders = stateFetchOrder.groupedOrders[date]!;
                  
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      date,
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Text(
                                      "₹${4567}",
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.separated(
                            shrinkWrap: true, 
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final data = orders[index];
                              return OrderCard(
                                items: data.order,
                                total: '123',
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
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
