import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final IUserFacade iUserFacade;

  UserProvider(this.iUserFacade);

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Future<void> addUser() async {
    final result = await iUserFacade.addUser(
        usermodel: UserModel(
            phoneNumber: numberController.text,
            name: nameController.text,
            createdAt: Timestamp.now()));
    result.fold(
      (l) {
        l.toString();
      },
      (r) {
        r;
      },
    );
  }
}
