import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_crm/features/home/presentation/provider/home_provider.dart';
import 'package:food_crm/features/home/presentation/view/widgets/custom_elevated_button_widget.dart';
import 'package:food_crm/features/home/presentation/view/widgets/view_button_widet.dart';
import 'package:food_crm/features/order_history/presentation/view/today_order_history_sreen.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final homeProvider = Provider.of<HomeProvider>(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      homeProvider.updateDateTime(DateTime.now());
      homeProvider.getUsersCount();
      //homeProvider.fetchTodayOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF060606),
      appBar: AppBar(
        backgroundColor: const Color(0XFF060606),
        leading: Image.asset('assets/images/total-x-logo.png'),
      ),
      body:Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Consumer<HomeProvider>(
                  builder: (context, homePro, child) {
                    return  Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                       Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 96,
                        width: 144,
                        decoration: BoxDecoration(
                          color: const Color(0XFFE4E4E4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 13,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0XFF000000)),
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(
                                    fontSize: 32, color: Color(0XFF000000)),
                              )
                            ],
                          ),
                        ),
                      ),
                     Container(
                          height: 96,
                          width: 170,
                          decoration: BoxDecoration(
                            color: const Color(0XFFE4E4E4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homePro.formattedDate,
                                  style: const TextStyle(
                                      fontSize: 20, color: Color(0XFF000000)),
                                ),
                                Text(
                                  homePro.formattedTime,
                                  style: const TextStyle(
                                      fontSize: 30, color: Color(0XFF000000)),
                                )
                              ],
                            ),
                          ),
                      ),
                    ],
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
                                homePro.total.toString()  ,
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
                                        const TodayOrderHistoryScreen(),
                                  ));
                            },
                            backgroundColor: const Color(0XFFFFF200),
                          )
                        ],
                      ),
                    ),
                  ),
                  
                  
                    ],
                  );
                  },
                ),
               
                const SizedBox(
                  height: 42,
                ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UsersPaymentScreen(),
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
                                borderRadius: BorderRadius.circular(16)),
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
                            border: Border.all(color: const Color(0XFFFFF200))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 31,
                                backgroundColor: const Color(0XFFFFFFFF),
                                child: Image.asset('assets/images/money.png'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0XFFFFFFFF)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '₹4500.00',
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0XFFFFFFFF)),
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
                                      builder: (context) => const UserScreen(),
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
                                borderRadius: BorderRadius.circular(16)),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: Consumer<HomeProvider>(
                        builder: (context, homePro, child) {
                           return Container(
                          height: 100.93,
                          width: 234.35,
                          decoration: BoxDecoration(
                              color: const Color(0XFF131318),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0XFFFFF200))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 31,
                                  backgroundColor: const Color(0XFFFFFFFF),
                                  child: Image.asset('assets/images/person.png'),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Total Members',
                                      style: TextStyle(
                                          fontSize: 14, color: Color(0XFFFFFFFF)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      homePro.usersCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 24, color: Color(0XFFFFFFFF)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                        },
                       
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
       
    );
  }
}
