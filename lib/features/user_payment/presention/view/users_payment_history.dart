import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/presention/view/widgets/amount_bottomsheet.dart';
import 'package:food_crm/features/user_payment/presention/view/widgets/total_card.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class UserpaymentHistory extends StatefulWidget {
  const UserpaymentHistory({super.key});

  @override
  State<UserpaymentHistory> createState() => _UserpaymentHistoryState();
}

class _UserpaymentHistoryState extends State<UserpaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            )),
        title: const Text(
          "Name",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
           backgroundColor: AppColors.primaryColor,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserpaymentHistory(),));
                  },
                  child: InkWell(
                    onTap: () {
                         showBottomSheet(context: context, builder: (context) {
                        return const AmountBottomSheet();
                      },);
                 },
                    child: const ListTile(
                      trailing: Text("₹390.00",style: TextStyle(fontSize: 16,color: AppColors.whiteColor,fontWeight: FontWeight.w400)),
                      title: Text("Day",style: TextStyle(fontSize: 17,color: AppColors.whiteColor,fontWeight: FontWeight.w400),),
                      subtitle: Text("Date",style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.w300),),
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
