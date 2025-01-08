import 'package:flutter/material.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
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
      body: Consumer<UserProvider>(
        builder:(context, stateAdduser, child) {
           return Column(
          children: [
            TextFormField(
              controller:stateAdduser.nameController ,
              decoration: const InputDecoration(
                label: Text("name"),
              ),
            ),
            TextFormField(
              controller:stateAdduser.numberController ,
              decoration: const InputDecoration(
                label: Text("name"),
              ),
              keyboardType: TextInputType.number,
            )
          ],
           );
        },
        
        ),
    );
  }
}