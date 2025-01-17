import 'package:dartz/dartz.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';

abstract class IItemFacade {
  Future<Either<MainFailures, Unit>> addSuggestions({
    required List<ItemUploadingModel> itemList,
  }) {
    throw UnimplementedError("addSuggections() implementation");
  }

  Future<Either<MainFailures, List<ItemUploadingModel>>> fetchSuggestions() {
    throw UnimplementedError("fetchSuggestions () implementation");
  }
  
}
