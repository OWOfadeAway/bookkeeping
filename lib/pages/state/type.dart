import 'package:flutter/material.dart';
class Type {
  final String name;
  final String id;
  final IconData icon;
  Type(this.name, this.id, this.icon);
}
  List<Type> typeList = [
  Type('购物消费', 'life', Icons.shopping_cart_outlined),
  Type('吃饭消费', 'eat', Icons.restaurant_menu_outlined),
  Type('生活消费', 'life', Icons.nightlife_outlined),
  Type('娱乐消费', 'play', Icons.sports_esports_outlined),
  ];