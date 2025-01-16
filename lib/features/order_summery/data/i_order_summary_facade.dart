import 'package:dartz/dartz.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderSummaryFacade {
  Future<Either<MainFailures,List<UserModel>>> fetchUsers()async{
    throw UnimplementedError(' fetchUsers() error');
  }
}