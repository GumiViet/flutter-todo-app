import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Message"),);
  }
}
