import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/features/users/presentation/view/user_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final formKey = GlobalKey<FormState>();

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
          ),
        ),
        title: const Text(
          "Add New People",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, stateAdduser, child) {
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: stateAdduser.nameController,
                          decoration: const InputDecoration(
                            label: Text("Name"),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greyColor),
                            ),
                            labelStyle:
                                TextStyle(color: AppColors.whiteColor),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          cursorColor: AppColors.whiteColor,
                          style: const TextStyle(color: AppColors.whiteColor),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name cannot be empty, please enter a name.';
                            }
                            if (value.length < 3) {
                              return 'Name must be at least 3 letters long.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 37),
                        TextFormField(
                          controller: stateAdduser.numberController,
                          decoration: const InputDecoration(
                            label: Text("Phone Numbers"),
                            hintText: "Phone Number",
                            focusColor: AppColors.whiteColor,
                            labelStyle:
                                TextStyle(color: AppColors.whiteColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greyColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: AppColors.whiteColor,
                          maxLength: 10,
                          style: const TextStyle(color: AppColors.whiteColor),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Number cannot be empty.';
                            }
                            if (value.length != 10) {
                              return 'Mobile number must be 10 digits.';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Mobile number must contain digits only.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        onTap: () async {
                          if (formKey.currentState?.validate() == true) {
                            stateAdduser.addUser();
                            Navigator.pop(context);
                          }
                        },
                        buttontext: "Save", color: AppColors.primaryColor, textColor: AppColors.blackColor,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
