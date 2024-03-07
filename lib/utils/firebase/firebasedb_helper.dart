
import 'package:stand_chat_app/screen/chat/model/chat_model.dart';
import 'package:stand_chat_app/screen/profile/model/profile_model.dart';
import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDbHelper {
  static FireDbHelper fireDbHelper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  ProfileModel myProfileData = ProfileModel();

  Future<void> addProfileData(ProfileModel p1) async {
    await fireDb
        .collection("user")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}")
        .set(
      {
        "id": p1.uid,
        "name": p1.name,
        "mobile": p1.mobile,
        "bio": p1.bio,
        "email": p1.email,
        "address": p1.address,
        "image": p1.image,
      },
    );
  }

  Future<void> getProfile() async {
    DocumentSnapshot ds = await fireDb
        .collection("user")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}")
        .get();

    Map? data = ds.data() as Map?;

    if (data != null) {
      myProfileData = ProfileModel(
        name: data['name'],
        address: data['address'],
        bio: data['bio'],
        email: data['email'],
        image: data['image'],
        mobile: data['mobile'],
        uid: data['id'],
      );
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileData() {
    return fireDb
        .collection("user")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllContact() {
    return fireDb
        .collection("user")
        .where("id",
        isNotEqualTo: "${FireAuthHelper.fireAuthHelper.user!.uid}")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatContact(){
    return fireDb.collection("chat").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChat(String docID){return fireDb.collection("chat").doc(docID).collection("message").snapshots();
  }

  Future<void> sendMessage(ChatModel? model, ProfileModel? myProfile, ProfileModel? fProfile) async {
    String myUid = FireAuthHelper.fireAuthHelper.user!.uid;
    await fireDb
        .collection("chat")
        .doc(fProfile!.docId!=null?fProfile.docId:"$myUid-${fProfile.uid}")
        .collection("message")
        .add({
      "msg": model!.msg,
      "name": model.name,
      "id": model.id,
      "date": model.date,
      "time": model.time,
    });
    await fireDb.collection("chat").doc(fProfile.docId!=null?fProfile.docId:"$myUid-${fProfile.uid}").set({
      'date1': [
        myProfile!.name,
        myProfile.uid,
        myProfile.image,
        myProfile.address,
        myProfile.bio,
        myProfile.email,
        myProfile.mobile
      ],
      'date2': [
        fProfile.name,
        fProfile.uid,
        fProfile.image,
        fProfile.address,
        fProfile.bio,
        fProfile.email,
        fProfile.mobile
      ]
    });
  }


}