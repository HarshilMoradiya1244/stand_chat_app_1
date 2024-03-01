import 'package:stand_chat_app/screen/login/view/signup_screen.dart';
import 'package:stand_chat_app/screen/contact/view/contact_screen.dart';
import 'package:stand_chat_app/screen/home/view/home_screen.dart';
import 'package:stand_chat_app/screen/login/view/login_screen.dart';
import 'package:stand_chat_app/screen/login/view/signup_screen.dart';
import 'package:stand_chat_app/screen/profile/view/profile_screen.dart';
import 'package:stand_chat_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_route={
'/':(context) => const SplashScreen(),
 'signin':(context) => const SignInScreen(),
 'signup':(context) => const SignUpScreen(),
 'home':(context) => const HomeScreen(),
 'profile':(context) => const ProfileScreen(),
 'contact':(context) => const ContactScreen(),
};
