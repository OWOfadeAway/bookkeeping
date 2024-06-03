import 'package:bookkeeping/pages/compotens/ButtonCard.dart';
import 'package:bookkeeping/pages/compotens/Date.dart';
import 'package:bookkeeping/pages/compotens/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../database/sqlite.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SendType {
  late final String title;
  late final int payment;
  late final IconData icon;
  SendType(this.title, this.payment, this.icon);
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'payment': payment,
      'icon': icon,
    };
  }
}

class sendMoney {
  late final String type;
  late final int money;
  late final String date;
  sendMoney(this.type, this.money, this.date);
}

class _MyHomePageState extends State<MyHomePage> {
  RxList<SendItem> sendMoneyList = RxList<SendItem>();

  @override
  void initState(){
    createDatabase().then((value)async{
      List<SendItem> list = await queryAll(value);
      sendMoneyList.assignAll(list);
    });
  }

  List<SendType> sendTypeMap = [
    SendType('购物消费', 50, Icons.shopping_cart_outlined),
    SendType('吃饭消费', 50, Icons.restaurant_menu_outlined),
    SendType('生活消费', 50, Icons.nightlife_outlined),
    SendType('娱乐消费', 50, Icons.sports_esports_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: const ListTile(
                    leading: Icon(Icons.today),
                    title: Text('今日消费: 200', style: TextStyle(fontSize: 15)),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: const ListTile(
                    leading: Icon(Icons.thirty_fps_outlined),
                    title: Text('本月消费: 200', style: TextStyle(fontSize: 15)),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      flex: 2,
                      child: ButtonCard(
                        icon: Icons.receipt_long,
                        text: '账单',
                        backgroundColor: Colors.lightBlue[100] as Color,
                        color: Colors.deepOrangeAccent[200] as Color,
                        onTap: () {},
                      )),
                  Flexible(
                      flex: 2,
                      child: ButtonCard(
                        icon: Icons.edit_note_outlined,
                        text: '记录',
                        backgroundColor: Colors.amber[200] as Color,
                        color: Color.fromARGB(255, 255, 64, 105),
                        onTap: () {
                          Get.toNamed('/addSendItem');
                        },
                      )),
                ],
              ),
              MainCard(
                  title: '本月消费统计',
                  titleIcon: const Icon(Icons.equalizer),
                  trailing: const Text(
                    '查看更多',
                    style: TextStyle(fontSize: 15),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 95,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              children: sendTypeMap.map<Widget>((e) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      e.icon,
                                      size: 35,
                                      color: Color.fromARGB(255, 255, 64, 105),
                                    ),
                                    Text(
                                      e.title,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // ignore: prefer_interpolation_to_compose_strings
                                    Text(e.payment.toString() + '元')
                                  ],
                                );
                              }).toList()))
                    ],
                  )),
              MainCard(
                title: '消费日历',
                titleIcon: Icon(Icons.calendar_month),
                trailing: const Text(
                  '切换月份',
                  style: TextStyle(fontSize: 15),
                ),
                content: Dates(),
              ),
              MainCard(
                  title: '消费列表',
                  titleIcon: Icon(Icons.list_alt_outlined),
                  trailing: const Text(
                    '更多',
                    style: TextStyle(fontSize: 15),
                  ),
                  content:Container(child:  ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: sendMoneyList
                          .map<Widget>((e) => Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              width: MediaQuery.of(context).size.width * 0.94,
                              height: 50,
                              child: ListTile(
                                leading: e.type == 'life'
                                    ? Icon(Icons.nightlife_outlined)
                                    : Icon(Icons.sports_esports_outlined),
                                title: Text(e.type == 'life' ? '生活' : '娱乐消费'),
                                subtitle:Text('花费:${e.money.toString()}') ,
                                trailing:Text(e.date),
                              )))
                          .toList()))),
            ],
          ),
        )));
  }
}
