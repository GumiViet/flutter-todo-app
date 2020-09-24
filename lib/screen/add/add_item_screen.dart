import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@page
class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Add Item"),
    );
  }
}
