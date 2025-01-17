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

import '../../features/add_item/data/i_add_item_facade.dart' as _i920;
import '../../features/add_item/repo/i_add_item_impli.dart' as _i151;
import '../../features/order_summery/repo/I_order_summery_impli.dart' as _i724;
import '../../features/order_history/data/model/i_order_history_facade.dart' as _i1058;
import '../../features/order_history/repo/order_history_impl.dart' as _i690;
import '../../features/order_summery/data/i_order_summery_facade.dart' as _i212;
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
  gh.lazySingleton<_i920.IItemFacade>(
      () => _i151.IAddItemImpli(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i1058.IOrderHistoryFacade>(
      () => _i690.OrderHistoryImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i212.IOrderSummeryFacade>(
      () => _i724.IOrderSummeryImpli(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i413.IUserFacade>(() => _i108.IUserImpli(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i109.FirebaseInjectableModule {}
