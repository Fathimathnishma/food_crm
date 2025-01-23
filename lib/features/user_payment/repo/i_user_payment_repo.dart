import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserPaymentFacade)
class IUserPaymentRepo implements IUserPaymentFacade {
  final FirebaseFirestore firebaseFirestore;

  IUserPaymentRepo({required this.firebaseFirestore});

  @override
 Future<Either<MainFailures, List<Map<String, dynamic>>>> fetchUserPayment({
  required String userId,
}) async {
  try {
    final userRef = firebaseFirestore.collection(FirebaseCollection.users).doc(userId);
    final dailyOrderSnapshot = await userRef.collection('dailyOrder').get();

    if (dailyOrderSnapshot.docs.isEmpty) {
      return right([]); // Return an empty list if no orders exist
    }

    // This will hold the orders grouped by date
    final Map<String, List<UserDialyOrderModel>> ordersGroupedByDate = {};

    for (var doc in dailyOrderSnapshot.docs) {
      try {
        final docData = doc.data();
        final formattedDate = doc.id; // Assuming the document ID is the formatted date
        final userDialyOrder = UserDialyOrderModel.fromMap(docData);

        // If the date is already in the map, add the order to the existing list
        if (ordersGroupedByDate.containsKey(formattedDate)) {
          ordersGroupedByDate[formattedDate]?.add(userDialyOrder);
        } else {
          // Otherwise, create a new list with the current order
          ordersGroupedByDate[formattedDate] = [userDialyOrder];
        }
      } catch (e) {
        log("Error while parsing order data: $e");
      }
    }

    // Convert the grouped data into a list of maps for easier display
    final List<Map<String, dynamic>> ordersList = ordersGroupedByDate.entries.map((entry) {
      return {
        'date': entry.key, // The formatted date
        'orders': entry.value, // List of orders for that date
      };
    }).toList();

    return right(ordersList); // Return the list of orders grouped by date
  } catch (e) {
    log("Error fetching user payment data: $e");
    return left(MainFailures.serverFailures(errormsg: e.toString())); // Return failure in case of error
  }
}

}
