import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/order_details/presentation/provider/order_details_provider.dart';
import 'package:food_crm/features/order_details/presentation/widgets/total_amount_widget.dart';
import 'package:food_crm/features/order_details/presentation/widgets/user_widget.dart';
import 'package:food_crm/general/utils/app_colors.dart';

import 'package:food_crm/main.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  @override
  void initState() {
    final orderDetails =
        Provider.of<OrderDetailsProvider>(context, listen: false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
            orderDetails.fetchOrderById(orderId: widget.orderId);
        },);
  
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsProvider>(
        builder: (context, stateAddOrder, child) {
          if(stateAddOrder.itemsList.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }
      return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.greyColor,
              ),
            ),
            backgroundColor: AppColors.blackColor,
            title: const Text(
              ' Order Details',
              style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTabController(
              length:stateAddOrder.itemsList.length ,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order Summery',
                      style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
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
                          itemCount: stateAddOrder.itemsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final itemList = stateAddOrder.itemsList;
                            final data = itemList[index];
                          
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data.name),
                                      SizedBox(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.qty.toString()),
                                            Text("₹${data.price.toString()}"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'People',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Text(
                             stateAddOrder.foodTime,
                              style: const TextStyle(color: AppColors.whiteColor),
                            ),
                            const Icon(Icons.timer_sharp,
                                color: AppColors.primaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          for (var item in stateAddOrder.itemsList)
                            Tab(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(fontSize: 14)),
                                  const SizedBox(height: 5),
                                  Text(item.price.toString(),
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      ...stateAddOrder.itemsList.map((item) {
                        log(item.users.length.toString());
                        return item.users.isNotEmpty
                            ? ListView.builder(
                                itemCount: item.users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final user = item.users[index];
                                  return UserWidget(
                                    name: user.name,
                                    price: item.price.toString(),
                                    index: index,
                                    tabIndex:
                                        stateAddOrder.itemsList.indexOf(item),
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No Users',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                      }),
                    ],
                  )),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TotalAmountWidget(
              amount: stateAddOrder.totalAmount.toString(),
              title: 'Total',
            ),
          ));
    });
  }
}
