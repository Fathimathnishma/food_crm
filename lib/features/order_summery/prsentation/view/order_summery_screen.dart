import 'dart:developer';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/order_history/presentation/view/today_order_history_sreen.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/total_amot_widget.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/user_row_widget.dart';
import 'package:food_crm/general/utils/app_colors.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
    
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.greyColor,
          ),
          backgroundColor: AppColors.blackColor,
          title: const Text(
            'Make An Order',
            style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
          ),
        ),
        body: Consumer<AddItemProvider>(builder: (context, stateAddItem, child) {
           final itemList = stateAddItem.itemList;
          return DefaultTabController(
             length: stateAddItem.itemList.length + 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order Summery',
                      style: TextStyle(
                          fontSize: 16, color: AppColors.whiteColor),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: width * 1,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor,
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
                          itemCount: stateAddItem.itemList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final data = itemList[index];
                            log(stateAddItem.itemList.length.toString());
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
                                      Text(data.name.text),
                                      SizedBox(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.quantity.text),
                                            Text("₹${data.price.text}"),
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
                          fontSize: 16, color: AppColors.whiteColor),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ButtonsTabBar(
                    height: 58,
                    width: 124,
                    center: false,
                    physics: const NeverScrollableScrollPhysics(),
                    backgroundColor: AppColors.greyColor,
                    unselectedBackgroundColor: AppColors.blackColor,
                    unselectedBorderColor: AppColors.greyColor,
                    unselectedLabelStyle:
                        const TextStyle(color: AppColors.whiteColor),
                    labelStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      for (var item in itemList)
                        Tab(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.name.text,
                                  style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 5),
                              Text(item.price.text,
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
                            // Text(stateAddItem.total.toString(),
                            //     style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        for (var item in itemList)
                          Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: item.users.length,
                                  itemBuilder:
                                      (BuildContext context, int userIndex) {
                                    final user = item.users[userIndex];
                                    return UserRowWidget(
                                      name: user.name,
                                      qty: 2,
                                      amount: 0,
                                      index: userIndex,
                                      tabIndex: itemList.indexOf(item),
                                      onDelete: (int tabIndex, int userIndex) {
                                        itemList[tabIndex]
                                            .users
                                            .removeAt(userIndex);
                                      },
                                      controller:
                                          (int tabIndex, int userIndex) {
                                        itemList[tabIndex]
                                            .users[userIndex]
                                            .qtyController;
                                      },
                                    );
                                  },
                                ),
                              ),
                              ListTile(
                                trailing: SizedBox(
                                  width: 140,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Qty:${item.quantity.text}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.whiteColor),
                                      ),
                                      const Text(
                                        '₹${400}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const Text('Total Mount',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar:
            Consumer<AddItemProvider>(builder: (context, stateAddItem, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TotalAmountContainer(
              amount: "147",
              title: 'Total',
              buttonText: 'Save',
              onTap: () async {
              //  stateAddItem.clearData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TodayOrderHistoryScreen(),
                    ));
              },
            ),
          );
}));}
}
