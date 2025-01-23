import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IUserPaymentFacade {
  Future<Either<MainFailures, UserDialyOrderModel?>> fetchUserPayment({
    required String userId,
  }) async {
    throw UnimplementedError('fetchUserPayment() not implemented');
  }
}
