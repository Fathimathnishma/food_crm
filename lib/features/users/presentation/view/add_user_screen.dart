import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
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
            "Add New People",
            style: TextStyle(color: ClrConstant.whiteColor),
          ),
        ),
      body: Consumer<UserProvider>(
        builder:(context, stateAdduser, child) {
           return Padding(
             padding: const EdgeInsets.all(9.0),
             child: Column(
                       children: [
              SizedBox(
                width: 340,
                child: TextFormField(
                  controller:stateAdduser.nameController ,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ClrConstant.greyColor)),
                    labelStyle: TextStyle(color: ClrConstant.whiteColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                  ),
                  cursorColor: ClrConstant.whiteColor,
                  style: const TextStyle(color: ClrConstant.whiteColor), 
                ),
              ),
              const SizedBox( height: 37,),
              TextFormField(
                controller:stateAdduser.numberController ,
                decoration: const InputDecoration(
                  label: Text("Phone Numbers"),
                  hintText:"Phone Number" ,
                  focusColor: ClrConstant.whiteColor,
                  labelStyle: TextStyle(color: ClrConstant.whiteColor),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ClrConstant.greyColor)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                 
                ),
                keyboardType: TextInputType.number,
                cursorColor: ClrConstant.whiteColor,
                style: const TextStyle(color: ClrConstant.whiteColor), 
              )
                       ],
             ),
           );
        },
        
        ),
    );
  }
}