import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/features/user_payment/data/model/user_payment_model.dart';
import 'package:intl/intl.dart';

class UserPaymentProvider with ChangeNotifier {
  final IUserPaymentFacade iUserPaymentFacade;
  UserPaymentProvider(this.iUserPaymentFacade);

  List<dynamic> userPaymentList = []; // Raw fetched data
  List<UserPaymentModel> dayOrder = []; // Processed list for easier use
  Map<String, List<UserPaymentModel>> ordersGroupedByDate = {}; // Grouped by date
  List<String> availableDates = []; // List of unique dates to display

  // Format date (you can adjust this format as per your requirement)
  String formatCreatedAt(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime); // Format as dd MMMM yyyy
  }

  // Group orders by date
  void groupOrdersByDate() {
    ordersGroupedByDate.clear();
    availableDates.clear();

    for (var order in dayOrder) {
      String formattedDate = formatCreatedAt(order.createdAt);

      if (ordersGroupedByDate.containsKey(formattedDate)) {
        ordersGroupedByDate[formattedDate]?.add(order);
      } else {
        ordersGroupedByDate[formattedDate] = [order];
        availableDates.add(formattedDate); // Add new date to the available dates list
      }
    }

    // Sort the dates in descending order (latest first)
    availableDates.sort((a, b) => b.compareTo(a));

    notifyListeners(); // Notify listeners when data is updated
  }

  // Fetch user payment data
  Future<void> fetchUserPayment({required String userId}) async {
    try {
      // Fetch user payment data
      final result = await iUserPaymentFacade.fetchUserPayment(userId: userId);

      // Handle result
      result.fold(
        (failure) {
          log(failure.errormsg); // Log failure message
        },
        (success) {
          // Clear existing lists if needed
          userPaymentList.clear();
          dayOrder.clear();

          // Add all fetched data to the userPaymentList
          userPaymentList.addAll(success);

          // Assuming success contains a list of custom objects
          for (var rawData in success) {
            try {
              // If rawData is a map
              // Convert raw data into UserPaymentModel
              final userPayment = UserPaymentModel.fromMap(rawData);

              // Add to your dayOrder list (processed data)
              dayOrder.add(userPayment);
                        } catch (e) {
              log("Error while parsing payment data: $e");
            }
          }

          // After processing, group the data by date
          groupOrdersByDate();

          // Log updated lists
          log("User payment list updated: $userPaymentList");
          log("Day order list updated: $dayOrder");

          // Notify listeners about the changes (for UI updates)
          notifyListeners();
        },
      );
    } catch (e) {
      log("Error while fetching user payment: $e");
    }
  }

  // Get orders for a specific date
  List<UserPaymentModel> getOrdersForDate(String date) {
    return ordersGroupedByDate[date] ?? [];
  }

  // Clear data when needed
  void clearData() {
    userPaymentList = [];
    dayOrder = [];
    ordersGroupedByDate.clear();
    availableDates.clear();
  }
}
