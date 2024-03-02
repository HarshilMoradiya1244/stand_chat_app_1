import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand_chat_app/screen/chat/model/chat_model.dart';
import 'package:stand_chat_app/screen/profile/model/profile_model.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtMsg,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FireDbHelper.fireDbHelper.sendMassage(
                        fuid: profileModel.uid!,
                        chatModel: ChatModel(
                          date: "${DateTime.now()}",
                          msg: "${txtMsg.text}",
                          name: "${profileModel.name}",
                          time: "${TimeOfDay.now()}",
                        ),
                      );
                      txtMsg.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
