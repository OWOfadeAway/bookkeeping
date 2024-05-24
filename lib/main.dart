/*
 * @Description: 
 * @Author: jxh
 * @Date: 2024-04-18 10:50:42
 * @LastEditTime: 2024-04-19 11:17:49
 * @LastEditors: jxh
 */
import 'package:flutter/material.dart';
import './router/router.dart';

import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 120, 194, 255),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          )),
      initialRoute: "/",
      // onGenerateRoute: onGenerateRoute,
      defaultTransition: Transition.rightToLeft,
      getPages:AppPage.routes,
    );
  }
}
