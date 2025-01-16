import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/i_add_item_facade.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/order_summery/data/i_order_summary_facade.dart';
import 'package:food_crm/features/order_summery/prsentation/provider/order_summary_provider.dart';
import 'package:food_crm/features/splash/presentation/view/splash_screen.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/general/di/injection.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependancy();
  runApp(const MyApp());
}

late double height;
late double width;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(sl<IUserFacade>()),
        ),
        ChangeNotifierProvider(
          create: (_) => AddItemProvider(sl<IItemFacade>()),
        ),
        ChangeNotifierProvider(
            create: (_) => OrderSummaryProvider(
                iOrderSummaryFacade: sl<IOrderSummaryFacade>()))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
