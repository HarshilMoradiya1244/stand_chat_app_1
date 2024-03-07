import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand_chat_app/screen/chat/model/chat_model.dart';
import 'package:stand_chat_app/screen/profile/model/profile_model.dart';
import 'package:stand_chat_app/utils/firebase/firebase_authanticasion.dart';
import 'package:stand_chat_app/utils/firebase/firebasedb_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel profileModel = Get.arguments;
  TextEditingController txtMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: profileModel.image != null
            ? CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage("${profileModel.image}"),
        )
            : CircleAvatar(
          radius: 30,
          child: Text(
            "${profileModel.name!.substring(0, 1)}",
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        title: Text("${profileModel.name}"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          profileModel.docId == null
              ? Container()
              : StreamBuilder(
            stream:
            FireDbHelper.fireDbHelper.readChat(profileModel.docId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<ChatModel> massageList = [];

                QuerySnapshot? qs = snapshot.data;

                if (qs != null) {
                  List<QueryDocumentSnapshot> qsDocList = qs.docs;
                  for (var x in qsDocList) {
                    Map data = x.data() as Map;

                    ChatModel c1 = ChatModel(
                      name: data['name'],
                      msg: data['msg'],
                      time: data['time'],
                      date: data['date'],
                      id: data['id'],
                      docId: x.id,
                    );
                    massageList.add(c1);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: massageList.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: massageList[index].id ==
                            FireAuthHelper.fireAuthHelper.user!.uid
                            ? Alignment.bottomLeft
                            : Alignment.centerRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${massageList[index].name}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${massageList[index].msg}"),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txtMsg,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        ChatModel model = ChatModel(
                          id: FireAuthHelper.fireAuthHelper.user!.uid,
                          name: FireDbHelper.fireDbHelper.myProfileData.name,
                          msg: txtMsg.text,
                          time:
                          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                          date:
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        );
                        FireDbHelper.fireDbHelper.sendMessage(
                            model,
                            FireDbHelper.fireDbHelper.myProfileData,
                            profileModel);
                        txtMsg.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}