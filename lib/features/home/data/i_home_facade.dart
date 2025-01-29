import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IHomeFacade {
  Future<Either<MainFailures, List<OrderModel>>> fetchTodayOrderList(
      {required String todayDate}) async {
    throw UnimplementedError('fetchTodayOrderList() is not fetching');
  }

  Future<Either<MainFailures, List<UserModel>>> fetchUser() {
    throw UnimplementedError("  fetchUser() no implementation");
  }
    Stream<Either<MainFailures, Map<String,num>>> fetchUserCountTotal() {
    throw UnimplementedError(" fetchUserCountTotal no implementation");
  }
}
