import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/view/add_item_screen.dart';
import 'package:food_crm/features/order_history/presentation/provider/order_history_provider.dart';
import 'package:food_crm/features/order_history/presentation/view/order_history_sreen.dart';
import 'package:food_crm/features/order_history/presentation/view/widgets/order_card.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class TodayOrderHistoryScreen extends StatefulWidget {
  const TodayOrderHistoryScreen({super.key});

  @override
  State<TodayOrderHistoryScreen> createState() =>
      _TodayOrderHistoryScreenState();
}

class _TodayOrderHistoryScreenState extends State<TodayOrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    final historyProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyProvider.fetchOrders();
     
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
          "Today Orders",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddItemScreen(),
            ),
          );
        },
        tooltip: 'Add a new item',
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, stateFetchOrder, child) {
          if (stateFetchOrder.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            );
          }

          if (stateFetchOrder.todayOrders.isEmpty) {
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
              children: [
                SizedBox(
                  height: height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Column(
                          children: [
                            const Text(
                              "23 March",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "₹${stateFetchOrder.total.toString()}",
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OrderHistoryScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.calendar_month_sharp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: stateFetchOrder.todayOrders.length,
                    itemBuilder: (context, index) {
                      final order = stateFetchOrder.todayOrders[index];
                      return OrderCard(
                        items: order.order,
                        total: order.totalAmount.toString(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
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
