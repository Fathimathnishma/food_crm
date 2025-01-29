import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderDetailsFacade {
  Future<Either<MainFailures,OrderModel>> fetchOrderbyId({required String orderId})async{
    throw UnimplementedError('fetchOrderList() is not fetching');
  }
}