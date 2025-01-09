import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderFacade {
  Future<Either<MainFailures,OrderModel>> addOrders({required OrderModel orderModel})async{
    throw UnimplementedError('not adding orders');
  }

  Future<Either<MainFailures,List<OrderModel>>> fetchOrders()async{
    throw UnimplementedError('not fetching orders');
  }

  Future<Either<MainFailures,Unit>> deleteOrder({required String orderId})async{
    throw UnimplementedError('not delete order');
  }
}