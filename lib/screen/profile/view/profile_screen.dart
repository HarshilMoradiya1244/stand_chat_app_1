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
  TextEditingController txtImage = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {
    await controller.getProfileData();
    if (controller.data.value != null) {
      txtName.text = controller.data.value!['name'];
      txtBio.text = controller.data.value!['bio'];
      txtMobile.text = controller.data.value!['mobile'];
      txtEmail.text = controller.data.value!['email'];
      txtAddress.text = controller.data.value!['address'];
      txtImage.text = controller.data.value!['image'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile Screen"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: Padding(
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
                      image: txtImage.text,
                    );
                    FireDbHelper.fireDbHelper.addProfileData(p1);
                    Get.offAllNamed('home');
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
