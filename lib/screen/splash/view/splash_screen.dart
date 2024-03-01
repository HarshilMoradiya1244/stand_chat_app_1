import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      FireAuthHelper.fireAuthHelper.checkUser()? Navigator.pushReplacementNamed(context, 'home'): Navigator.pushReplacementNamed(context, 'signin');
    });

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Center(
          child: LottieBuilder.asset("assets/json/splash.json",
          height: 200,width: 200,),
        )
      ),
    );
  }
}
