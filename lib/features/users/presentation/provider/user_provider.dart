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
    if (!isPhoneNumberValid()) {
      CustomFluttertoast.showToast("Failed to add user. Fix errors.");
      return;
    }
    final cleanPhoneNumber =
        numberController.text.replaceAll(RegExp(r'[^\d]'), '');
    final formattedPhoneNumber = '+91$cleanPhoneNumber';

    if (formattedPhoneNumber.isEmpty) {
      return CustomFluttertoast.showToast(
          "Invalid phone number format. Please try again.");
    }

    final userModel = UserModel(
      phoneNumber: formattedPhoneNumber,
      name: nameController.text,
      createdAt: Timestamp.now(),
    );

    final result = await iUserFacade.addUser(usermodel: userModel);

    result.fold(
      (failure) {
        CustomFluttertoast.showToast(
            "Failed to add user");
      },
      (success) {
       
        CustomFluttertoast.showToast("User added successfully");
        nameController.clear();
        numberController.clear();
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

  bool isPhoneNumberValid() {
    if (numberController.text.trim().isEmpty) {
      CustomFluttertoast.showToast("Phone number cannot be empty");
      return false;
    }

    if (!RegExp(r"^[0-9]{10}$").hasMatch(numberController.text.trim())) {
      CustomFluttertoast.showToast(
          "Please enter a valid 10-digit phone number");
      return false;
    }

    return true;
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
      (l) {
        l.toString();
      },
      (r) {
        r;
        users.removeWhere((user) => user.id == userId);
        notifyListeners();
      },
    );
  }

  clearData() {
    users = [];
  }
}
