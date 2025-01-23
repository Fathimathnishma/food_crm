import 'package:dartz/dartz.dart';
import 'package:food_crm/features/user_payment/data/model/user_payment_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IUserPaymentFacade {
  Future<Either<MainFailures, List<OrderDailyReportModel>>> fetchUserPayment(
      {required String userId}) async {
    throw UnimplementedError('fetchUserPayment() not implemented');
  }
 

}
