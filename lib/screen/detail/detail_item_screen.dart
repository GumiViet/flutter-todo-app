import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@page
class DetailItemScreen extends StatefulWidget {
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Detail Item"));
  }
}
