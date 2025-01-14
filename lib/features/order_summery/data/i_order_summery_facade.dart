import 'package:dartz/dartz.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IOrderSummeryFacade {
 Future<Either<MainFailures, List<UserModel>>> fetchUsers() {
    throw UnimplementedError("fetchSuggestions () implementation");
  }
}