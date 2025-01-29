import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_details/data/i_order_details_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IOrderDetailsFacade)


class IOrderDetailsImpli implements IOrderDetailsFacade{
   final FirebaseFirestore firebaseFirestore;

  IOrderDetailsImpli({required this.firebaseFirestore});
  @override
  Future<Either<MainFailures, OrderModel>> fetchOrderbyId({required String orderId}) async {
   try{
    final orderRef = await firebaseFirestore.collection(FirebaseCollection.order).doc(orderId).get();
       if (!orderRef.exists) {
      return left(const MainFailures.serverFailures(errormsg: "not found")); 
    }

    final order = OrderModel.fromMap(orderRef.data()!);
       return right(order);
   }catch (e){
    return left(MainFailures.serverFailures(errormsg: e.toString()));
   }

  }
  
}