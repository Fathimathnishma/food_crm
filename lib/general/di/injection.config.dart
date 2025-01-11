// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/add_item/data/i_item_facade.dart' as _i760;
import '../../features/add_item/repo/i_item_impli.dart' as _i278;
import '../../features/order/data/model/i_order_facade.dart' as _i333;
import '../../features/order/repo/order_impl.dart' as _i825;
import '../../features/users/data/i_auth_facade.dart' as _i413;
import '../../features/users/repo/i_auth_impli.dart' as _i108;
import 'injectable_module.dart' as _i109;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  await gh.factoryAsync<_i109.FirebaseServices>(
    () => firebaseInjectableModule.firebaseServices,
    preResolve: true,
  );
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i760.IItemFacade>(
      () => _i278.IItemImpli(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i333.IOrderFacade>(
      () => _i825.OrderImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i413.IUserFacade>(() => _i108.IUserImpli(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i109.FirebaseInjectableModule {}
