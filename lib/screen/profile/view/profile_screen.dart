import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stand_chat_app/screen/profile/controller/profile_controller.dart';
import 'package:stand_chat_app/screen/profile/model/profile_model.dart';
import 'package:stand_chat_app/screen/widget/custome_textfiled.dart';
import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:stand_chat_app/utils/firebase/firebasedb_helper.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtImage = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.  getProfileData(),
          builder:(context, snapshot) {
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            else if(snapshot.hasData){
              DocumentSnapshot? ds=snapshot.data;
              Map? data = ds?.data() as Map?;
              if(data!=null){

                txtName.text = data['name'];
                txtEmail.text = data['email'];
                txtMobile.text = data['mobile'];
                if(data['image']!=null)
                {
                  txtImage.text = data['image'];
                }
                txtAddress.text = data['address'];
                txtBio.text = data['bio'];
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                      ),
                      CustomeTextFiled(
                        label: "Name",
                        controller: txtName,
                      ),
                      CustomeTextFiled(
                        label: "Bio",
                        controller: txtBio,
                      ),
                      CustomeTextFiled(
                        label: "Mobile",
                        controller: txtMobile,
                      ),

                      CustomeTextFiled(
                        label: "Email",
                        controller: txtEmail,
                      ),
                      CustomeTextFiled(
                        label: "Address",
                        controller: txtAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ProfileModel p1 = ProfileModel(
                            uid: FireAuthHelper.fireAuthHelper.user!.uid,
                            name: txtName.text,
                            mobile: txtMobile.text,
                            bio: txtBio.text,
                            email: txtEmail.text,
                            address: txtAddress.text,
                            image: null,
                          );
                          FireDbHelper.fireDbHelper.addProfileData(p1);
                          Get.offAllNamed('home');
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}