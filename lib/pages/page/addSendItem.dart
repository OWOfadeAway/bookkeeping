import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddSendItem extends StatefulWidget{
  const AddSendItem({super.key});
  @override
  State<AddSendItem> createState() =>_AddSendItem();

}
class _AddSendItem extends State<AddSendItem>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:AppBar(
          title: Text('记一笔'),
        )
    );
  }

}