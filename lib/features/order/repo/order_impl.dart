import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order/data/model/i_order_facade.dart';
import 'package:food_crm/features/order/data/model/service_order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/collection_const.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderFacade)
class OrderImpl implements IOrderFacade {
  final FirebaseFirestore firebaseFirestore;
  OrderImpl({required this.firebaseFirestore});

  bool noMoreData = false;
  DocumentSnapshot? lastDocument;
 



  //  @override
  // Future<Either<MainFailures, String>> addOrders({required ItemModel ordermodel}) async {
  //      try {
  //     final orderRef = firebaseFirestore.collection(Collection.order);

  //     final id = orderRef.doc().id;

  //     final order = ordermodel.copyWith(id: id);

  //     await orderRef.doc(id).set(order.toMap());

  //     return right("");
  //   } catch (e) {
  //     return left(MainFailures.serverFailures(errormsg: e.toString()));
  //     }

  // }
  

  // @override
  // Future<Either<MainFailures, List<ItemModel>>> fetchOrders() async {
  //   try {
  //     Query query = firebaseFirestore
  //         .collection(Collection.orderList)
  //         .orderBy('createdAt', descending: true);

  //     if (lastDocument != null) {
  //       query = query.startAfterDocument(lastDocument!);
  //     }

  //     QuerySnapshot querySnapshot = await query.limit(10).get();

  //     if (querySnapshot.docs.length < 10) {
  //       noMoreData = true;
  //     } else {
  //       lastDocument = querySnapshot.docs.last;
  //     }

  //     final newList = querySnapshot.docs
  //         .map((order) =>
  //             ItemModel.fromMap(order.data() as Map<String, dynamic>))
  //         .toList();

  //     return right(newList);
  //   } catch (e) {
  //     return left(MainFailures.serverFailures(errormsg: e.toString()));
  //   }
  // }
  
  // @override
  // Future<Either<MainFailures, Unit>> deleteOrder({required String orderId}) async{
  //    try {
  //      final orderRef = firebaseFirestore.collection(Collection.orderList).doc(orderId);

  //      await orderRef.delete();

  //      return right(unit);

  //    } catch (e) {
  //      return left(MainFailures.serverFailures(errormsg: e.toString()));
  //    }
  // }


  //   @override
  // Future<Either<MainFailures, String>> addOrderList(
  //     {required ServiceOrderModel ordermodel}) async {
  //   try {
  //     final orderRef = firebaseFirestore.collection(Collection.orderList);
  //     final id = orderRef.doc().id;
  //     final order = ordermodel.copyWith(id: id);

  //     await orderRef.doc(id).set(order.toMap());

  //     return right("order added");
  //   } catch (e) {
  //     return left(MainFailures.serverFailures(errormsg: e.toString()));
  //   }
  // }
  
  // @override
  // Future<Either<MainFailures, List<ServiceOrderModel>>> fetchOrderList({required String orderId}) async {
  //   try{
  //     final orderDoc = await firebaseFirestore.collection(Collection.orderList).doc(orderId).get(); 
      
  //      if (orderDoc.exists) {
  //     final data = orderDoc.data()!;
  //     final ordersList = List<Map<String, dynamic>>.from(data['orders'] ?? []);
  //     List<ServiceOrderModel> serviceOrders = ordersList.map((order) {
  //       return ServiceOrderModel.fromMap(order);
  //     }).toList();
  //     return right(serviceOrders);
  //   } else {

  //     return left(const MainFailures.serverFailures(errormsg: "Order not found"));
  //   }
  // } catch (e) {

  //   return left(MainFailures.serverFailures(errormsg: e.toString()));
  // }
 // }
}
