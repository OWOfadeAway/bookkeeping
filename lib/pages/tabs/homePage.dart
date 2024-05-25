/*
 * @Description: 
 * 
 * @Author: jxh
 * @Date: 2024-04-17 11:16:51
 * @LastEditTime: 2024-05-24 17:37:20
 * @LastEditors: jxh
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.2,
                  child: ListTile(
                    leading: Icon(Icons.today),
                    title: Text('今日消费: 200', style: TextStyle(fontSize: 15)),
                  )),
              Container(
                width: MediaQuery.of(context).size.width / 2.2,
                  child: ListTile(
                    leading: Icon(Icons.thirty_fps_outlined),
                    title: Text('本月消费: 200', style: TextStyle(fontSize: 15)),
                  ))
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.lightBlue[100]),
                            height: 80,
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              onTap: () => {},
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Icon(Icons.receipt_long,
                                          color: Colors.deepOrangeAccent[200],
                                          size: 45.0)),
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        '账单',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 5.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic),
                                      )),
                                ],
                              ),
                            )),
                      )),
                  Flexible(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.amber[200]),
                            height: 80,
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              onTap: () => {},
                              child: const Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Icon(Icons.edit_note_outlined,
                                          color: const Color.fromARGB(
                                              255, 255, 64, 105),
                                          size: 45.0)),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        '记录',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 5.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic),
                                      )),
                                ],
                              ),
                            ),
                          ))),
                ],
              )
            ],
          ),
        ));
  }
}
