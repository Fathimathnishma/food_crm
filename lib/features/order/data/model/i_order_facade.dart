import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order/data/model/order_model.dart';
import 'package:food_crm/features/order/data/model/service_order_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderFacade {
  Future<Either<MainFailures,String>> addOrderList({required ServiceOrderModel ordermodel})async{
    throw UnimplementedError('not adding orders');
  }
  Future<Either<MainFailures,String>> addOrders({required OrderModel ordermodel})async{
    throw UnimplementedError('not adding orders');
  }

  Future<Either<MainFailures,List<OrderModel>>> fetchOrders()async{
    throw UnimplementedError('not fetching orders');
  }

  Future<Either<MainFailures,Unit>> deleteOrder({required String orderId})async{
    throw UnimplementedError('not delete order');
  }
}