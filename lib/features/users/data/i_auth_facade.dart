import 'package:dartz/dartz.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IUserFacade {
Future<Either<MainFailures,String>> addUser({required UserModel usermodel}){
    throw UnimplementedError("no implementation");
  }
Future<Either<MainFailures,List<UserModel>>> fetchUser(){
    throw UnimplementedError("no implementation");
  }
Future<Either<MainFailures,Unit>> removeUser({required String userId}){
    throw UnimplementedError("no implementation");
  }
}