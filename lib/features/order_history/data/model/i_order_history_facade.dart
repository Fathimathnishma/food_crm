import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_history/data/model/service_order_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderHistoryFacade {
Future<Either<MainFailures,List<OrderModel>>> fetchOrderList()async{
    throw UnimplementedError('fetchOrderList() is not fetching');
  }


}