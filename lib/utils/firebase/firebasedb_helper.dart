
import 'package:stand_chat_app/screen/profile/model/profile_model.dart';
import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDbHelper {

  static FireDbHelper fireDbHelper = FireDbHelper._();
  FireDbHelper._();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  Future<void> addProfileData(ProfileModel p1) async {
    await fireDb
        .collection("user")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}")
        .set(
      {
        "name": p1.name,
        "mobile": p1.mobile,
        "bio": p1.bio,
        "email": p1.email,
        "address": p1.address,
        "image": p1.image,
      },
    );
  }

  Stream<DocumentSnapshot<Map>> getProfileData()  {
    Stream<DocumentSnapshot<Map>> data =  fireDb
        .collection("user")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}")
        .snapshots();
    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProfile(){
    return fireDb.collection("user").where("id",isNotEqualTo: FireAuthHelper.fireAuthHelper.user!.uid).snapshots();

  }
}