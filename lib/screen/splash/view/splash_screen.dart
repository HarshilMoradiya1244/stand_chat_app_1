import 'dart:async';

import 'package:get/get.dart';
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
    bool isLogin = FireAuthHelper.fireAuthHelper.checkUser();
    Timer(
      const Duration(seconds: 3),
          () => Get.offAllNamed(isLogin==false?'signin':'home'),
    );
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
