import 'package:flutter/material.dart';
import 'package:food_crm/features/amount/presention/view/widgets/amount_bottomsheet.dart';
import 'package:food_crm/features/amount/presention/view/widgets/total_card.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/color_const.dart';

class UserTotalAmount extends StatefulWidget {
  const UserTotalAmount({super.key});

  @override
  State<UserTotalAmount> createState() => _UserTotalAmountState();
}

class _UserTotalAmountState extends State<UserTotalAmount> {
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
          "Name",
          style: TextStyle(color: ClrConstant.whiteColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
           backgroundColor: ClrConstant.primaryColor,
        child: const Icon(Icons.add,size: 40,),
          onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserScreen(),));
        },),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TotalCardWidget(subtitle: "124"),
             Expanded(
               child: ListView.separated(
                         itemCount: 4,
                         itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserTotalAmount(),));
                  },
                  child: InkWell(
                    onTap: () {
                         showBottomSheet(context: context, builder: (context) {
                        return const AmountBottomSheet();
                      },);
                 },
                    child: const ListTile(
                      trailing: Text("₹390.00",style: TextStyle(fontSize: 16,color: ClrConstant.whiteColor,fontWeight: FontWeight.w400)),
                      title: Text("Day",style: TextStyle(fontSize: 17,color: ClrConstant.whiteColor,fontWeight: FontWeight.w400),),
                      subtitle: Text("Date",style: TextStyle(color: ClrConstant.greyColor,fontWeight: FontWeight.w300),),
                    ),
                  ),
                );
                         }, 
                         separatorBuilder: (context, index) {
                return  Divider(color: Colors.grey.shade600,);
                         }, ),
             ), 
            
            ],
            
        ),
      ),
    );
  }
}
