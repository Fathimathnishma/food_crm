import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';

class OrderCard extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String rate;
  final int listCount;

  const OrderCard({
    super.key,
    required this.itemName, // Customizable row text
    required this.quantity,
    required this.rate, required this.listCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: ClrConstant.greyColor, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 340,
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
                  Text("Item"), // Static text
                  Row(
                    children: [
                      Text("Qty"), // Static text
                      SizedBox(width: 20),
                      Text("Rate"), // Static text
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Customizable Row Content
          ListView.builder(
            itemCount:listCount ,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) { 
              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(itemName), // Customizable
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(quantity), // Customizable
                         
                          Text(rate), 
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
            },
           
          ),
        ],
      ),
    );
  }
}
