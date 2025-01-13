import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class UsersPaymentScreen extends StatefulWidget {
  const UsersPaymentScreen({super.key});

  @override
  State<UsersPaymentScreen> createState() => _UsersPaymentScreenState();
}

class _UsersPaymentScreenState extends State<UsersPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          leading: InkWell( onTap:() {
            Navigator.pop(context);
          }, child:  const Icon(Icons.arrow_back_ios_new,color: AppColors.whiteColor,)),        
            title: const Text(
            "Total Amount",
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
           backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add,size: 40,),
          onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserScreen(),));
        },),
        body: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const UsersPaymentScreen(),));
              },
              child: const ListTile(
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total",style: TextStyle(fontSize: 13,color: Colors.grey)),
                    Text("₹390.00",style: TextStyle(fontSize: 16,color: AppColors.whiteColor)),
                  ],
                ),
                leading:  CircleAvatar(
                 radius: 23,
                 backgroundColor: AppColors.whiteColor,
                                  ),
                title: Text("name",style: TextStyle(fontSize: 17,color: AppColors.whiteColor),),
                subtitle: Text("phonenumber",style: TextStyle(color: AppColors.greyColor),),
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return  Divider(color: Colors.grey.shade600,);
          }, ), 
    );
  }
}