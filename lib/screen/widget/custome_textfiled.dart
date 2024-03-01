import 'package:flutter/material.dart';

class CustomeTextFiled extends StatelessWidget {
  Color? labelColor;
  String? label;
  TextEditingController? controller;

  CustomeTextFiled({this.controller,this.label,this.labelColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      decoration: InputDecoration(
          label: Text(label??""),
          labelStyle: TextStyle(
            color: labelColor ?? Colors.green,
          )
      ),
    );
  }
}