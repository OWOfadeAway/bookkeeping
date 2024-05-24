/*
 * @Description: 
 * 
 * @Author: jxh
 * @Date: 2024-04-17 11:16:51
 * @LastEditTime: 2024-05-24 15:31:45
 * @LastEditors: jxh
 */
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class User extends StatefulWidget {
  const User({super.key});
  @override
  State<User> createState() => _user();
}

// ignore: camel_case_types
class _user extends State<User> {
  void tapWell(){
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            top: true,
            bottom: true,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColor, Colors.white],
              )),
              child: Material(
                  color: const Color.fromRGBO(0, 0, 0, 0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 80, 0, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                            radius: 38,
                                            backgroundImage: NetworkImage(
                                                "https://c-ssl.duitang.com/uploads/item/201706/30/20170630143159_4WymV.png")),
                                        Container(
                                          height: 55,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: const Column(
                                            mainAxisSize: MainAxisSize.max,
                                            // 起始点
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "aaa",
                                                style: TextStyle(fontSize: 22),
                                              ),
                                              Text("aaa"),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                                Container(
                                    height: 100,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    ))
                              ],
                            )),
                        ListView(
                          shrinkWrap: true,
                          //每个子组件的高度
                          padding: const EdgeInsets.all(15.0),
                          children: <Widget>[
                            Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: Color.fromRGBO(247, 244, 237, 1)
                                ),
                                child:  InkWell(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  // ignore: unnecessary_const
                                  onTap: (){} ,
                                  child:const ListTile(
                                    //  Color.fromRGBO(247, 244, 237, 1),
                                    
                                    leading: Icon(Icons.settings),
                                    title: Text("设置"),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  )),
            )));
  }
}
