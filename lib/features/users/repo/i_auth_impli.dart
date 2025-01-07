import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/collection_const.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserFacade)

class IUserImpli implements IUserFacade{
  final FirebaseFirestore firestore;
  final FirebaseAuth fireauth;

  IUserImpli( this.firestore,  this.fireauth);

  @override
  Future<Either<MainFailures, String>> addUser({required UserModel usermodel}) async {
    try{
      final id = firestore.collection(Collection.users).doc().id;
      final userRef = firestore.collection(Collection.users).doc(id);
      final user=usermodel.copyWith(id: id);
      await userRef.set(user.toMap());
      return right("user added");
    }catch(e){
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  
}