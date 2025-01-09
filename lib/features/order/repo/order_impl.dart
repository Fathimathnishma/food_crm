import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order/data/model/i_order_facade.dart';
import 'package:food_crm/features/order/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderFacade)
class OrderImpl implements IOrderFacade {
  final FirebaseFirestore firebaseFirestore;
  OrderImpl({required this.firebaseFirestore});

  bool noMoreData = false;
  DocumentSnapshot? lastDocument;

  @override
  Future<Either<MainFailures, OrderModel>> addOrders(
      {required OrderModel orderModel}) async {
    try {
      final orderRef = firebaseFirestore.collection('order');

      final id = orderRef.doc().id;

      final order = orderModel.copyWith(id: id);

      await orderRef.doc(id).set(order.toMap());

      return right(order);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<OrderModel>>> fetchOrders() async {
    try {
      Query query = firebaseFirestore
          .collection('order')
          .orderBy('createdAt', descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.limit(10).get();

      if (querySnapshot.docs.length < 10) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final newList = querySnapshot.docs
          .map((order) =>
              OrderModel.fromMap(order.data() as Map<String, dynamic>))
          .toList();

      return right(newList);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
  
  @override
  Future<Either<MainFailures, Unit>> deleteOrder({required String orderId}) async{
     try {
       final orderRef = firebaseFirestore.collection('order').doc(orderId);

       await orderRef.delete();

       return right(unit);

     } catch (e) {
       return left(MainFailures.serverFailures(errormsg: e.toString()));
     }
  }
}
