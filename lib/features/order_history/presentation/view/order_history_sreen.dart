// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_crm/features/order_details/presentation/view/order_details_screen.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final orderHistory =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderHistory.initData(scrollController: _scrollController);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderHistoryProvider>(
      builder: (context, stateFetchOrder, child) {
        final dateKeys = stateFetchOrder.groupedOrders.keys.toList();
        
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                stateFetchOrder.clearFilter();
              },
              child: const Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor),
            ),
            actions: [
              stateFetchOrder.isFiltered
                  ? CircleAvatar(
                      backgroundColor: AppColors.greyColor,
                      radius: 12,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, color: AppColors.blackColor, size: 24),
                        onPressed: stateFetchOrder.clearFilter,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        DateTime todayDate = DateTime.now();
                        final selectedRange = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2025, 1, 21),
                          lastDate: todayDate,
                        );
                        if (selectedRange != null) {
                          stateFetchOrder.filterOrderBySpecificDateRange(
                            selectedRange.start,
                            selectedRange.end,
                          );
                        }
                      },
                      child: const SizedBox(
                        height: 25,
                        width: 25,
                        child: Image(
                          image: AssetImage("assets/images/preference-horizontal.png"),
                        ),
                      ),
                    ),
            ],
            backgroundColor: AppColors.blackColor,
            title: const Text(
              "History",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 19),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stateFetchOrder.isFiltered
                    ? Text(
                        "Results: (${stateFetchOrder.selectedStartDate}) to (${stateFetchOrder.selectedEndDate})",
                        style: const TextStyle(fontSize: 12, color: AppColors.whiteColor),
                      )
                    : const Text(
                        "Showing Results: All",
                        style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                      ),
                const SizedBox(height: 16),
                Expanded(
                  child: stateFetchOrder.isLoading && stateFetchOrder.allOrders.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(color: AppColors.primaryColor),
                        )
                      : stateFetchOrder.allOrders.isEmpty
                          ? const Center(
                              child: Text("No data", style: TextStyle(color: AppColors.whiteColor)),
                            )
                          : ListView.separated(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: dateKeys.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final date = dateKeys[index];
                                final orders = stateFetchOrder.groupedOrders[date]!;

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
                                              date,
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "₹${stateFetchOrder.calculateTotalForDate(date)}",
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
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: orders.length,
                                      itemBuilder: (context, index) {
                                        final data = orders[index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OrderDetailsScreen(orderId: data.id!),
                                              ),
                                            );
                                          },
                                          child: OrderCard(
                                            items: data.order,
                                            total: data.totalAmount.toString(),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                                    ),
                                  ],
                                );
                              },
                            ),
                ),
                if (stateFetchOrder.noMoreData)
                  const Center(
                    child: Text(
                      "No more orders available.",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
