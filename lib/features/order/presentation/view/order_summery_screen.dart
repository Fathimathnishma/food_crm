import 'dart:developer';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/item/presentation/provider/item_provider.dart';
import 'package:food_crm/features/order/presentation/view/today_order_history_sreen.dart';
import 'package:food_crm/features/order/presentation/view/widgets/total_amot_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/user_row_widget.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';
import 'package:provider/provider.dart';

class OrderSummeryScreen extends StatefulWidget {
  const OrderSummeryScreen({super.key});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        userProvider.fetchUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ClrConstant.blackColor,
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: ClrConstant.greyColor,
          ),
          backgroundColor: ClrConstant.blackColor,
          title: const Text(
            'Make An Order',
            style: TextStyle(fontSize: 18, color: ClrConstant.whiteColor),
          ),
        ),
        body: Consumer<ItemProvider>(builder: (context, stateAddItem, child) {
          final orderList = stateAddItem.localorder;
          return DefaultTabController(
            length: stateAddItem.localorder.length + 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order Summery',
                      style: TextStyle(
                          fontSize: 16, color: ClrConstant.whiteColor),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: width * 1,
                    decoration: BoxDecoration(
                      color: ClrConstant.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: width * 1,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Item"),
                                Row(
                                  children: [
                                    Text("Qty"),
                                    SizedBox(width: 20),
                                    Text("Rate"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: stateAddItem.localorder.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final data = stateAddItem.localorder[index];
                            log(stateAddItem.localorder.length.toString());
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data.item),
                                      SizedBox(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.quantity.toString()),
                                            Text("₹${data.price}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'People',
                      style: TextStyle(
                          fontSize: 16, color: ClrConstant.whiteColor),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ButtonsTabBar(
                    height: 58,
                    width: 124,
                    center: false,
                    physics: const NeverScrollableScrollPhysics(),
                    backgroundColor: ClrConstant.greyColor,
                    unselectedBackgroundColor: ClrConstant.blackColor,
                    unselectedBorderColor: ClrConstant.greyColor,
                    unselectedLabelStyle:
                        const TextStyle(color: ClrConstant.whiteColor),
                    labelStyle: const TextStyle(
                      color: ClrConstant.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      for (var item in orderList)
                        Tab(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.item,
                                  style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 5),
                              Text(item.rate.toString(),
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      const Tab(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 5),
                            Text('150', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Consumer<UserProvider>(
                    builder: (context, stateAddUser, child) => Expanded(
                      child: TabBarView(
                        children: [
                          for (var order in orderList)
                            ListView.builder(
                              itemCount: stateAddUser.users.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final dataUser = stateAddUser.users[index];
                                // final data = stateAddOrder.localorder[index];
                                return UserRowWidget(
                                  name: dataUser.name,
                                  qty: order.quantity,
                                  amount: order.price,
                                );
                              },
                            ),
                          const Text('Total Mount',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar:
            Consumer<ItemProvider>(builder: (context, stateAddItem, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TotalAmountContainer(
              amount: stateAddItem.total.toString(),
              title: 'Total',
              buttonText: 'Save',
              onTap: () async {
                stateAddItem.clearData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TodayOrderHistoryScreen(),
                    ));
              },
            ),
          );
        }));
  }
}
