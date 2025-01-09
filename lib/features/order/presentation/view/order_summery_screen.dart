import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_card.dart';
import 'package:food_crm/features/order/presentation/view/widgets/total_amot_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/user_row_widget.dart';
import 'package:food_crm/general/utils/color_const.dart';

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
          backgroundColor: ClrConstant.blackColor,
          title: const Text(
            'Make An Order',
            style: TextStyle(fontSize: 18, color: ClrConstant.whiteColor),
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Order Summery',
                    style:
                        TextStyle(fontSize: 16, color: ClrConstant.whiteColor),
                  ),
                ),
                const SizedBox(height: 24),
                const OrderCard(
                  itemName: 'Chapathi',
                  quantity: '2',
                  rate: '200',
                  listCount: 5,
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'People',
                    style:
                        TextStyle(fontSize: 16, color: ClrConstant.whiteColor),
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
                const Expanded(
                  child: TabBarView(
                    children: [
                      UserRowWidget(
                          count: 5,
                          initial: 'js',
                          name: 'Jaseel',
                          qty: 2,
                          amount: 100),
                      UserRowWidget(
                          count: 5,
                          initial: 'js',
                          name: 'Jaseel',
                          qty: 0.5,
                          amount: 50),
                      Text('Total Mount',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TotalAmountContainer(
            amount: '₹500.00',
            title: 'Total',
            buttonText: 'Save',
            onTap: () {},
          ),
        ));
  }
}
