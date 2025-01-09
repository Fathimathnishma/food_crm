import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_Card.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';

class OrderHistorySreen extends StatefulWidget {
  const OrderHistorySreen({super.key});

  @override
  State<OrderHistorySreen> createState() => _OrderHistorySreenState();
}

class _OrderHistorySreenState extends State<OrderHistorySreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: ClrConstant.whiteColor),
        ),
        backgroundColor: ClrConstant.blackColor,
        title: const Text(
          "History ",
          style: TextStyle(color: ClrConstant.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Showing Results : All",
                    style: TextStyle(fontSize: 16, color: ClrConstant.whiteColor),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: 2,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "23 March",
                                    style: TextStyle(
                                      color: ClrConstant.whiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    "₹290.50",
                                    style: TextStyle(
                                      color: ClrConstant.whiteColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), 
                        itemCount: 2,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                        itemBuilder: (context, index) {
                          return const OrderCard(
                            itemName: "chappathi",
                            quantity: "10",
                            rate: "6",
                            total: "890",
                            listCount: 2,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
