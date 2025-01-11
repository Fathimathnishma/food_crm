import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/add_item/data/i_item_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/collection_const.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IItemFacade)
class IItemImpli implements IItemFacade{
  final FirebaseFirestore firestore;

IItemImpli(this.firestore);
DocumentSnapshot? lastDoc;


  @override
 Future<Either<MainFailures, List<UserModel>>> fetchUser() async {
    log("fetching");
    try {
      final userRef =
          firestore.collection(Collection.users).orderBy("createdAt");
      Query query = userRef.limit(10);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      final querySnapshot = await query.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  }
  
