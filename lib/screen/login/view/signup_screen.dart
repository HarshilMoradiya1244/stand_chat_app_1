import 'package:stand_chat_app/screen/widget/custome_textfiled.dart';
import 'package:stand_chat_app/utils/constant.dart';
import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:stand_chat_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail =TextEditingController();
  TextEditingController txtPassword =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$registrationTitle",
                    style: txtBold18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$registrationDec",
                    style: txtBook14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(label: name),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(label: email,controller: txtEmail,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(label: password,controller: txtPassword,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(label: confirmPassword),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      String msg = await FireAuthHelper.fireAuthHelper.singUp(email: txtEmail.text, password: txtPassword.text);
                      Get.back();
                      Get.snackbar(msg,"");
                    },
                    child: Container(
                      height: 48,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffF3F6F6),

                      ),
                      child: Center(
                        child: Text(
                          "$registrationButton",
                          style: txtBook16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}