import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_card.dart';
import 'package:food_crm/general/utils/color_const.dart';

class OrderSummeryScreen extends StatefulWidget {
  const OrderSummeryScreen({super.key});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'People',
                style: TextStyle(fontSize: 16, color: ClrConstant.whiteColor),
              ),
            ),
            const SizedBox(height: 24),
            const OrderCard(
              itemName: 'Chapathi',
              quantity: '20000',
              rate: '200',
              listCount: 2,
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Order Summary',
                style: TextStyle(fontSize: 16, color: ClrConstant.whiteColor),
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            TabBar(
              labelColor: ClrConstant.blackColor,
              unselectedLabelColor: ClrConstant.greyColor,
              controller: _tabController,
              indicatorColor: ClrConstant.whiteColor,
              tabs: [
                Container(
                    height: 68,
                    width: 116,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0XFFE4E4E4)),
                    child: const Column(
                      children: [Tab(text: 'Chappathi'), Text('100')],
                    )),
                Container(
                    height: 68,
                    width: 116,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ClrConstant.greyColor)),
                    child: const Column(
                      children: [Tab(text: 'Curry'), Text('100')],
                    )),
                Container(
                    height: 68,
                    width: 116,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0XFF088CFF)),
                    child: const Tab(text: 'Total')),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text('Chappathi Content')),
                  Center(child: Text('Curry Content')),
                  Center(child: Text('Total Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
