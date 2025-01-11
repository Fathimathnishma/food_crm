import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/view/make_an_order_screen.dart';
import 'package:food_crm/features/order/presentation/view/order_history_sreen.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_Card.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';

class TodayOrderHistoryScreen extends StatefulWidget {
  const TodayOrderHistoryScreen({super.key});

  @override
  State<TodayOrderHistoryScreen> createState() =>
      _TodayOrderHistoryScreenState();
}

class _TodayOrderHistoryScreenState extends State<TodayOrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ClrConstant.blackColor,
        appBar: AppBar(
          backgroundColor: ClrConstant.blackColor,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: ClrConstant.whiteColor,
              )),
          title: const Text(
            "Today Orders",
            style: TextStyle(color: ClrConstant.whiteColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MakeAnOrderScreen(),
                ));
          },
          backgroundColor: ClrConstant.primaryColor,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),

        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "23 March",
                            style: TextStyle(
                                color: ClrConstant.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "₹290.50",
                            style: TextStyle(
                                color: ClrConstant.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderHistorySreen(),
                              ));
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: ClrConstant.whiteColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(
                              Icons.calendar_month_sharp,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const OrderCard(
                      itemName: "chappathi",
                      quantity: "1",
                      rate: "6",
                      listCount: 2,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
              )
            ])));
  }
}
