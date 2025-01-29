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
import '../../features/home/data/i_home_facade.dart' as _i914;
import '../../features/home/repo/i_home_impli.dart' as _i741;
import '../../features/order_details/data/i_order_details_facade.dart' as _i746;
import '../../features/order_details/repo/i_order_details_impli.dart' as _i789;
import '../../features/order_history/data/i_order_history_facade.dart' as _i731;
import '../../features/order_history/repo/i_order_history_impl.dart' as _i174;
import '../../features/order_summery/data/i_order_summery_facade.dart' as _i212;
import '../../features/order_summery/repo/I_order_summery_impli.dart' as _i946;
import '../../features/user_payment/data/i_user_payment_facade.dart' as _i454;
import '../../features/user_payment/repo/i_user_payment_impli.dart' as _i965;
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
  gh.lazySingleton<_i212.IOrderSummeryFacade>(
      () => _i946.IOrderSummeryImpli(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i731.IOrderHistoryFacade>(() => _i174.IOrderHistoryImpl(
      firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i454.IUserPaymentFacade>(() =>
      _i965.IUserPaymentRepo(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i746.IOrderDetailsFacade>(() => _i789.IOrderDetailsImpli(
      firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i914.IHomeFacade>(
      () => _i741.IHomeImpli(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i413.IUserFacade>(() => _i108.IUserImpli(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i109.FirebaseInjectableModule {}
