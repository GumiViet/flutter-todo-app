import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@page
class EditItemScreen extends StatefulWidget {
  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Edit Item"),
    );
  }
}
