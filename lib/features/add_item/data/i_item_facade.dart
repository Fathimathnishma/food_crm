import 'package:dartz/dartz.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IItemFacade {
  Future<Either<MainFailures,List<UserModel>>> fetchUser(){
    throw UnimplementedError("no implementation");
  }
  
} 