import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/widgets/fluttertoast.dart';

class UserProvider extends ChangeNotifier {
  final IUserFacade iUserFacade;

  UserProvider(this.iUserFacade);

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final phoneValidation = RegExp(r"^[0-9]{10}$");
  bool isLoading = false;
  List<UserModel> users = [];

  Future<void> addUser() async {
    final cleanPhoneNumber =
        numberController.text.replaceAll(RegExp(r'[^\d]'), '');
    final formattedPhoneNumber = '+91$cleanPhoneNumber';

    final userModel = UserModel(
      phoneNumber: formattedPhoneNumber,
      name: nameController.text,
      createdAt: Timestamp.now(),
      monthlyTotal: 0
      
    );

    final result = await iUserFacade.addUser(usermodel: userModel);

    result.fold(
      (failure) {
        Customtoast.showToast("Failed to add user");
      },
      (success) {
        Customtoast.showToast("User added successfully");
        clearController();
        notifyListeners();
      },
    );
  }

  String getInitials(String name) {
    List<String> nameParts = name.split(' ');

    String firstLetter =
        nameParts.isNotEmpty ? nameParts[0][0].toUpperCase() : '';
    String lastLetter =
        nameParts.length > 1 ? nameParts[1][0].toUpperCase() : '';

    return firstLetter + lastLetter;
  }

  Future<void> fetchUser() async {
    clearData();
    isLoading = true;
    notifyListeners();
    final result = await iUserFacade.fetchUser();
    result.fold(
      (l) {
        l.toString();
        isLoading = false;
        notifyListeners();
      },
      (user) {
        users.addAll(user);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> removeUser({required String userId}) async {
    final result = await iUserFacade.removeUser(userId: userId);
    result.fold(
      (failure) {
        failure.errormsg;
      },
      (success) async {
        log('Delete User');
        users.removeWhere((user) => user.id == userId);
        try {
          await FirebaseFirestore.instance
              .collection('general')
              .doc('general')
              .update({'count': FieldValue.increment(-1)});

          log('Count decremented successfully');
        } catch (e) {
          log('Count decremented failed');
        }
        notifyListeners();
      },
    );
  }

  void clearData() {
    users = [];
  }

  void clearController() {
    nameController.clear();
    numberController.clear();
  }

  Future<void> getUsersCount() async {
    final result = await iUserFacade.fetchGeneral();

    result.fold(
      (failure) {
        log(failure.errormsg);
      },
      (success) {},
    );
  }
}
