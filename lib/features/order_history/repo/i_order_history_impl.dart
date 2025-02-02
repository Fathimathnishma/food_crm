import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_history/data/i_order_history_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderHistoryFacade)
class IOrderHistoryImpl implements IOrderHistoryFacade {
  final FirebaseFirestore firebaseFirestore;

  IOrderHistoryImpl({required this.firebaseFirestore});

  bool noMoreData = false;
  DocumentSnapshot? lastDocument;

  @override
  Future<Either<MainFailures, List<OrderModel>>> fetchOrderList() async {
     if (noMoreData) return right([]);
    try {
      log("Fetching orders...");
      Query query = firebaseFirestore
          .collection(FirebaseCollection.order)
          .orderBy("createdAt",descending: true);

      if(lastDocument!=null){
        query = query.startAfterDocument(lastDocument!);

      }

      final querySnapshot = await query.limit(10).get();

       if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }
      if(querySnapshot.docs.length<10){
        noMoreData = true;
      }

      
      final orders = querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String,dynamic>))
          .toList();
      return right(orders);
    } catch (e, stackTrace) {
      log("Error while fetching orders: $e");
      log("Stack trace: $stackTrace");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
   }
   }
   
     @override
     void clearData() {
    lastDocument= null;
    noMoreData=false;
     }
     
       @override
       Future<Either<MainFailures, List<OrderModel>>> fetchOrderByRange({required DateTime startDate, required DateTime endDate}) async {
          try {
  
    final startOfDay = Timestamp.fromDate(DateTime(startDate.year, startDate.month, startDate.day));
    final endOfDay = Timestamp.fromDate(DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999));

      log("Fetching orders...");
      final todayOrder = await firebaseFirestore
          .collection(FirebaseCollection.order)
          .where("createdAt" ,isGreaterThanOrEqualTo: startOfDay)
          .where("createdAt",isLessThanOrEqualTo: endOfDay)
          .orderBy("createdAt",descending: true).get();
    

      if (todayOrder.docs.isEmpty) {
        log("No orders found.");
        
      }
     final orders = todayOrder.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList();
      return right(orders);

    } catch (e) {
      log("Error while fetching orders: $e");
     
      return left(MainFailures.serverFailures(errormsg: e.toString())) ;
    }
       
}


}