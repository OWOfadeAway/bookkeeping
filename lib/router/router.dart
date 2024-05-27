import 'package:get/get.dart';
import '../pages/tab.dart';
import '../pages/page/addSendItem.dart';
class AppPage {
  static final routes = [
    GetPage(name: "/", page: () => const Tabs()),
    GetPage(name: "/addSendItem", page: () => const AddSendItem())
  ];
}