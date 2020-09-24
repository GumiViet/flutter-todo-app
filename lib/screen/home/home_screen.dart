import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:route_annotation/route_annotation.dart';

@page
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
        ),
        body: Container(child: Text("Home")));
  }
}
