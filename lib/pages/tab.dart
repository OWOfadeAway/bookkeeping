import 'package:flutter/material.dart';
import './tabs/homePage.dart';
import './tabs/user.dart';
class Tabs extends StatefulWidget {
  final int index;
  const Tabs({super.key,this.index=0});
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex=widget.index;
  }
  final List<Widget> _pages = const [
    MyHomePage(),
    User()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color.fromARGB(255, 35, 141, 255), //选中的颜色
          // iconSize:35,           //底部菜单大小
          currentIndex: _currentIndex, //第几个菜单选中
          onTap: (index) {
            //点击菜单触发的方法
            //注意
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
          ]),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, //配置浮动按钮的位置
    );
  }
}
