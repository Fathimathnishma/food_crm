import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/order_sreen.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:food_crm/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
   void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderSreen()), 
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      body: Center(
        child: SizedBox(
          height: height*0.11,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*0.05,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/total-x-logo.png"))),
              ),
              SizedBox(height: height*0.02,),
              const Text("FOOD MANAGEMENT APP",style:TextStyle(fontSize: 15,color: ClrConstant.whiteColor) ,)
            ],
          ),
        ),
      ),
    );
  }
}
