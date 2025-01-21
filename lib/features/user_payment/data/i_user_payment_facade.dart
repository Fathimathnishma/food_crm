import 'package:dartz/dartz.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IUserPaymentFacade {
  Future<Either<MainFailures, List<Map<String, dynamic>>>> fetchUserPayment(
      {required String userId}) async {
    throw UnimplementedError('fetchUserPayment() not implemented');
  }
}
