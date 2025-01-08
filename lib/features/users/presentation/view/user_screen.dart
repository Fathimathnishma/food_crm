import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/color_const.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
            "Peoples",
            style: TextStyle(color: ClrConstant.whiteColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserScreen(),));
        },
        backgroundColor: ClrConstant.primaryColor,
        child: const Icon(Icons.add,size: 40,),),
        body: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) {
            return const ListTile(
              leading:  SizedBox(
              width: 78,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child:  Icon(Icons.delete_outline, color: Colors.red,size: 30,),
                  ),
                  // SizedBox(width: 2),
                   CircleAvatar(
                    radius: 23,
                    backgroundColor: ClrConstant.whiteColor,
                  ),
                ],
              ),
            ),
              title: Text("name",style: TextStyle(fontSize: 17,color: ClrConstant.whiteColor),),
              subtitle: Text("phonenumber",style: TextStyle(color: ClrConstant.greyColor),),
            );
          }, 
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 30,
            );
          }, ),
    );
  }
}