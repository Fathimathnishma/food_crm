import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/home/presentation/provider/home_provider.dart';
import 'package:food_crm/features/today_order/presentation/provider/today_order_provider.dart';
import 'package:food_crm/features/order_summery/prsentation/provider/order_summery_provider.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/total_amot_widget.dart';
import 'package:food_crm/features/order_summery/prsentation/view/widget/user_row_widget.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/utils/dialy_enum.dart';
import 'package:food_crm/general/widgets/circularload.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';
import 'package:food_crm/main.dart';
import 'package:provider/provider.dart';

class OrderSummeryScreen extends StatefulWidget {
  final List<ItemAddingModel> itemList;
  const OrderSummeryScreen({super.key, required this.itemList});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final summeryProvider =
        Provider.of<OrderSummeryProvider>(context, listen: false);
    summeryProvider.init(widget.itemList);

    if (summeryProvider.itemsList.isNotEmpty) {
      tabController = TabController(

        length: summeryProvider.itemsList.length, 
        vsync: this,
      );
      tabController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderSummeryProvider>(
        builder: (context, stateAddOrder, child) {
      if (stateAddOrder.isLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
            strokeWidth: 2,
          ),
        );
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
              'Make An Order',
              style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
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
                    // SizedBox(width: 100,),
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            stateAddOrder
                                .mealToString(stateAddOrder.selectedMeal),
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                          PopupMenuButton<FoodTime>(
                            icon: const Icon(Icons.timer_sharp,
                                color: AppColors.primaryColor),
                            onSelected: (FoodTime result) {
                              setState(() {
                                stateAddOrder.selectedMeal = result;
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return FoodTime.values.map((FoodTime meal) {
                                return PopupMenuItem<FoodTime>(
                                  value: meal,
                                  child: Text(stateAddOrder.mealToString(
                                      meal)), // Show readable string
                                );
                              }).toList();
                            },
                          ),
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
                      controller: tabController,
                      height: 58,
                      width: 124,
                      center: false,
                      physics: const NeverScrollableScrollPhysics(),
                      backgroundColor: AppColors.greyColor,
                      unselectedBackgroundColor: AppColors.blackColor,
                      unselectedBorderColor: AppColors.greyColor,
                      borderWidth: 1,
                      borderColor: Colors.black,
                      
                      tabs: [
                        for (int index = 0;
                            index < stateAddOrder.itemsList.length;
                            index++)
                          Tab(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  stateAddOrder.itemsList[index].name.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: tabController.index == index
                                        ? AppColors.blackColor
                                        : AppColors.greyColor,
                                    fontWeight: tabController.index == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  stateAddOrder.itemsList[index].price.text,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: tabController.index == index
                                        ? AppColors.blackColor
                                        : AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  children: [
                    ...stateAddOrder.itemsList.map((item) {
                      return item.users.isNotEmpty
                          ? ListView.builder(
                              itemCount: item.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                final user = item.users[index];
                                return UserRowWidget(
                                  name: user.name,
                                  price: item.price.text,
                                  index: index,
                                  tabIndex:
                                      stateAddOrder.itemsList.indexOf(item),
                                  onDelete: (int tabIndex, int userIndex) {
                                    stateAddOrder.removeUserFromSummery(
                                      tabIndex: tabIndex,
                                      userIndex: userIndex,
                                      price: item.price.text,
                                    );
                                  },
                                  controller: item.users[index].qty,
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TotalAmountContainer(
                amount: stateAddOrder.overallTotal.toString(),
                title: 'Total',
                buttonText: 'Save',
                onTap: () async {

                  stateAddOrder.checkQty(tabIndex: tabController.index);
                  if (stateAddOrder.isValid) {
                    Loading.addShowDialog(context, message: "adding");
                    await stateAddOrder.addOrder(
                      onSuccess: (order) {
                        context
                            .read<TodayOrderProvider>()
                            .addLocalTodayOrder(order);
                        context.read<HomeProvider>().addLocalTodayOrder();
                        context.read<AddItemProvider>().clearItems();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(navigatorKey.currentContext!);
                      },
                    );
                  } else {
                    Customtoast.showErrorToast(
                        "Please check the values you've given.");
                  }
                }),
          ));
    });
  }
}
