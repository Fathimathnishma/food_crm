import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';

class OrderCard extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String rate;
  final int listCount;
  final String? total;

  const OrderCard({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.rate,
    required this.listCount,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            itemCount: listCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(itemName),
                        SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(quantity),
                              Text("₹$rate"),
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
          if (total != null) ...[
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: 49, child: Divider(color: ClrConstant.blackColor)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "₹$total",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
