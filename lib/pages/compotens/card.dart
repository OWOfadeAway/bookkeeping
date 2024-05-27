/*
 * @Description: 
 * @Author: jxh
 * @Date: 2024-05-25 11:35:24
 * @LastEditTime: 2024-05-25 15:43:20
 * @LastEditors: jxh
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainCard extends StatelessWidget {
  final String title ;
  late final Widget content;
  final Widget trailing;
  final Widget titleIcon;

  MainCard({Key? key, this.title='', required this.content,this.trailing = const SizedBox.shrink(),required this.titleIcon})
      : super(key: key);


  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
          
          color: Colors.blue[50],
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child:Column(
          children:[
             ListTile(
                    trailing: trailing,
                    leading: titleIcon,
                    title: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
            content
          ]
        )
      ),
    );
  }
}
