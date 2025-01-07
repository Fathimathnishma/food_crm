import 'package:flutter/material.dart';
import 'package:food_crm/general/di/injection.dart';

void main()async {
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
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;


      return const MaterialApp(
        debugShowCheckedModeBanner: false,
       // home: SplashScreen(),
      
    );
  }
}