
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/provider/order_provider.dart';
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
        body: Consumer<OrderProvider>(builder: (context, stateAddOrder, child) {
          return DefaultTabController(
            length: 3,
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
                          itemCount: stateAddOrder.localorder.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final data = stateAddOrder.localorder[index];
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
                    backgroundColor: Colors.red,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Chappathi', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 5),
                            Text('100', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Curry', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 5),
                            Text('50', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Tab(
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
                     builder: (context, stateAddUser, child) => 
                     Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: stateAddUser.users.length,
                            itemBuilder: (BuildContext context, int index) { 
                              final dataUser = stateAddUser.users[index];
                              final data = stateAddOrder.localorder[index];
                              return UserRowWidget( name: dataUser.name, qty:data.quantity  , amount: data.price );
                             },),
                     
                          ListView.builder(
                            itemCount: stateAddUser.users.length,
                            itemBuilder: (BuildContext context, int index) { 
                              final dataUser = stateAddUser.users[index];
                              final data = stateAddOrder.localorder[index];
                              return UserRowWidget( name: dataUser.name, qty:data.quantity  , amount: data.price);
                             },),
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
            Consumer<OrderProvider>(builder: (context, stateAddOrder, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TotalAmountContainer(
              amount: stateAddOrder.total.toString(),
              title: 'Total',
              buttonText: 'Save',
              onTap: () async {
                await stateAddOrder.addOrders();
                stateAddOrder.clearData();
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
