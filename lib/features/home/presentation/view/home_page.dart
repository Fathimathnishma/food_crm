import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/home/presentation/provider/home_provider.dart';
import 'package:food_crm/features/home/presentation/view/widgets/admin_container_widget.dart';
import 'package:food_crm/features/home/presentation/view/widgets/custom_elevated_button_widget.dart';
import 'package:food_crm/features/home/presentation/view/widgets/date_time_container_widget.dart';
import 'package:food_crm/features/home/presentation/view/widgets/view_button_widet.dart';
import 'package:food_crm/features/today_order/presentation/view/today_order_history_sreen.dart';
import 'package:food_crm/features/user_payment/presention/view/users_payment_screen.dart';
import 'package:food_crm/features/users/presentation/view/user_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        homeProvider.init();
       // homeProvider.listenToUserCount();
        homeProvider.startDateTimeStream();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF060606),
      appBar: AppBar(
        backgroundColor: const Color(0XFF060606),
        leading: Image.asset('assets/images/total-x-logo.png'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homePro, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(

              children: [
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [AdminContainerWidget(), DateTimeContainerWidget()],
                ),
                const SizedBox(
                  height: 38,
                ),
                Container(
                  height: 105,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0XFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0XFFFFFFFF)),
                            ),
                            Text(
                              homePro.todayTotal.toString(),
                              style: const TextStyle(
                                  fontSize: 34, color: Color(0XFFFFFFFF)),
                            ),
                          ],
                        ),
                        CustomElevatedButton(
                          text: 'Make A Order',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TodayOrderScreen.TodayOrdersScreen(),
                                ));
                          },
                          backgroundColor: const Color(0XFFFFF200),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 42,
                ),
                StreamBuilder(
                    stream: homePro.listenToUserCount(),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 153,
                                width: 370,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ViewButtonWidget(
                                        text: 'View',
                                        onPressed: () {
                                          log(homePro.balanceAmount.toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UsersPaymentScreen(
                                                  total: homePro.balanceAmount,
                                                ),
                                              ));
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 53.76,
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFFFF200),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 10,
                                child: Container(
                                  height: 100.93,
                                  width: 234,
                                  decoration: BoxDecoration(
                                      color: const Color(0XFF131318),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0XFFFFF200))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 31,
                                          backgroundColor:
                                              const Color(0XFFFFFFFF),
                                          child: Image.asset(
                                              'assets/images/money.png'),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Total Amount',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0XFFFFFFFF)),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              ("₹${homePro.balanceAmount.toStringAsFixed(1)}"),
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0XFFFFFFFF)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                height: 153,
                                width: 380,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ViewButtonWidget(
                                        text: 'View',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const UserScreen(),
                                              ));
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 53.76,
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFFFF200),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 10,
                                child: Container(
                                  height: 100.93,
                                  width: 234.35,
                                  decoration: BoxDecoration(
                                      color: const Color(0XFF131318),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0XFFFFF200))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 31,
                                          backgroundColor:
                                              const Color(0XFFFFFFFF),
                                          child: Image.asset(
                                              'assets/images/person.png'),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Total Members',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0XFFFFFFFF)),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              homePro.usersCount.toString(),
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0XFFFFFFFF)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
