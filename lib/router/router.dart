import 'package:get/get.dart';
import '../pages/tab.dart';

class AppPage {
  static final routes = [
    GetPage(name: "/", page: () => const Tabs()),
  ];
}