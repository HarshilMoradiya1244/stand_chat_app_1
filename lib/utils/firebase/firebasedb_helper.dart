
import 'package:stand_chat_app/screen/chat/model/chat_model.dart';
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
        "id":p1.uid,
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

  Future<Map?> getProfile() async {
    FireAuthHelper.fireAuthHelper.checkUser();
    DocumentSnapshot? ds = await fireDb
        .collection("user")
        .doc(FireAuthHelper.fireAuthHelper.user!.uid)
        .get() ?? null;
    if (ds != null) {
      Map data = ds.data() as Map;
      return data;
    }
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProfile(){
    return fireDb.collection("user").where("id",isNotEqualTo: FireAuthHelper.fireAuthHelper.user!.uid).snapshots();
  }
  void sendMassage({required String fuid, required ChatModel chatModel}) {
    fireDb
        .collection("chat")
        .doc("${FireAuthHelper.fireAuthHelper.user!.uid}:$fuid}")
        .collection("message")
        .add({
      "name": chatModel.name,
      "msg": chatModel.msg,
      "date": chatModel.date,
      "time": chatModel.time
    });
  }
}