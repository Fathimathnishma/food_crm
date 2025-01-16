import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/order/presentation/view/today_order_history_sreen.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/total_amot_widget.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/user_row_widget.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class OrderSummeryScreen extends StatefulWidget {
  final List<ItemUploadingModel> itemList;
  const OrderSummeryScreen({super.key, required this.itemList});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddItemProvider>(context, listen: false).fetchSugetion();
      context.read<UserProvider>().fetchUser().then(
        (value) {
          final users = context.read<UserProvider>().users;
          context.read<AddItemProvider>().generateItems(users);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.greyColor,
          ),
          onPressed: () => Navigator.pop(context),
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
          length: itemList.length + 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                ),
                const SizedBox(height: 24),
                _buildItemSummary(context, itemList),
                const SizedBox(height: 24),
                const Text(
                  'People',
                  style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                ),
                const SizedBox(height: 24),
                _buildTabs(context, itemList),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildItemSummary(
      BuildContext context, List<ItemUploadingModel> itemList) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildItemSummaryHeader(),
          ListView.builder(
            itemCount: widget.itemList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final data = widget.itemList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.name.text),
                      SizedBox(
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.quantity.text),
                            Text("₹${data.price.text}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemSummaryHeader() {
    return Container(
      height: 50,
      width: double.infinity,
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
    );
  }

  Widget _buildTabs(BuildContext context, List<ItemUploadingModel> itemList) {
    return Expanded(
      child: Column(
        children: [
          ButtonsTabBar(
            height: 58,
            width: 116,
            backgroundColor: AppColors.greyColor,
            unselectedBackgroundColor: AppColors.blackColor,
            unselectedBorderColor: AppColors.greyColor,
            unselectedLabelStyle: const TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            labelStyle: const TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            borderWidth: 1,
            borderColor: Colors.amberAccent,
            contentPadding: const EdgeInsets.symmetric(vertical: 7),
            contentCenter: true,
            tabs: [
              for (var item in itemList)
                Tab(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name.text,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text("₹${item.price.text}",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              const Tab(
                child: Column(
                  children: [
                    Text('Total', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (var item in itemList)
                  ListView.builder(
                    itemCount: item.users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final user = item.users[index];
                      // log('Displaying user: ${user.name} for item: ${item.name.text}');

                      return UserRowWidget(
                          name: user.name,
                          amount: 100,
                          index: index,
                          tabIndex: itemList.indexOf(item),
                          onDelete: (tabIndex, userIndex) {
                            setState(() {
                              itemList[tabIndex].users.removeAt(userIndex);
                            });
                          },
                          controller: user.qtyController);
                    },
                  ),
                const Center(
                  child: Text('Total Amount',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Consumer<AddItemProvider>(builder: (context, stateAddItem, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TotalAmountContainer(
          amount: '100',
          title: 'Total',
          buttonText: 'Save',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TodayOrderHistoryScreen(),
              ),
            );
          },
        ),
      );
    });
  }
}
