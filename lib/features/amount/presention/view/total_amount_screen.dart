import 'package:flutter/material.dart';
import 'package:food_crm/features/amount/presention/view/user_total_amount.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/color_const.dart';

class TotalAmountScreen extends StatefulWidget {
  const TotalAmountScreen({super.key});

  @override
  State<TotalAmountScreen> createState() => _TotalAmountScreenState();
}

class _TotalAmountScreenState extends State<TotalAmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      appBar: AppBar(
          backgroundColor: ClrConstant.blackColor,
          leading: InkWell( onTap:() {
            Navigator.pop(context);
          }, child:  const Icon(Icons.arrow_back_ios_new,color: ClrConstant.whiteColor,)),        
            title: const Text(
            "Total Amount",
            style: TextStyle(color: ClrConstant.whiteColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
           backgroundColor: ClrConstant.primaryColor,
        child: const Icon(Icons.add,size: 40,),
          onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserScreen(),));
        },),
        body: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserTotalAmount(),));
              },
              child: const ListTile(
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total",style: TextStyle(fontSize: 13,color: Colors.grey)),
                    Text("₹390.00",style: TextStyle(fontSize: 16,color: ClrConstant.whiteColor)),
                  ],
                ),
                leading:  CircleAvatar(
                 radius: 23,
                 backgroundColor: ClrConstant.whiteColor,
                                  ),
                title: Text("name",style: TextStyle(fontSize: 17,color: ClrConstant.whiteColor),),
                subtitle: Text("phonenumber",style: TextStyle(color: ClrConstant.greyColor),),
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return  Divider(color: Colors.grey.shade600,);
          }, ), 
    );
  }
}