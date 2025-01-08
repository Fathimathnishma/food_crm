import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';

class OrderSreen extends StatefulWidget {
  const OrderSreen({super.key});

  @override
  State<OrderSreen> createState() => _OrderSreenState();
}

class _OrderSreenState extends State<OrderSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      appBar: AppBar(
        backgroundColor: ClrConstant.blackColor,
        title: const Text("Today Orders",style: TextStyle(color: ClrConstant.whiteColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: height*0.1,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("23 March",style: TextStyle(color: ClrConstant.whiteColor ,fontSize: 13,fontWeight: FontWeight.w300),),
                      Text("₹290.50",style: TextStyle(color: ClrConstant.whiteColor ,fontSize: 19,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Icon(Icons.calendar_month)
                ],
              ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 137,
                      width: 380,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           const Row(
                             children: [
                               Text("Item"),
                               Row(
                             children: [
                               Text("Qty"),
                               SizedBox(width: 10,),
                                Text("Rate"),
                             ],
                           ),
                             ],
                           ),
                           
                          
                          Container(
                              height: 100,
                              color: ClrConstant.whiteColor,
                            ),
                          // Container(
                          //   height: height*0.15,
                            
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(width*0.03)
                          //   ),
                          //   child: 
                          // ),
                        ],
                      ),
                    );
                  },
                   separatorBuilder: (context, index) {
                     return SizedBox(height: height*0.02,);
                   }, 
                   ),
              )
          ],
        ),
      ),
    );
  }
}