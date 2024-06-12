import 'package:bookkeeping/pages/compotens/ButtonCard.dart';
import 'package:bookkeeping/pages/compotens/Date.dart';
import 'package:bookkeeping/pages/compotens/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import '../../database/sqlite.dart';
import 'package:get/get.dart';
import '../state/type.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
getSendType(String type){
  for(var i in typeList) {
    if(i.id == type){
      return i;
    }
  }
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
  RxInt mouthSend = RxInt(0);
  RxInt daySend = RxInt(0);
  RxInt buySend = RxInt(0);
  RxInt eatSend = RxInt(0);
  RxInt lifeSend = RxInt(0);
  RxInt playSend = RxInt(0);
  RxList<SendType> sendTypeMap = RxList([
    SendType('购物消费', 50, Icons.shopping_cart_outlined),
    SendType('吃饭消费', 50, Icons.restaurant_menu_outlined),
    SendType('生活消费', 50, Icons.nightlife_outlined),
    SendType('娱乐消费', 50, Icons.sports_esports_outlined),
  ]);
  updatePageData(){
    createDatabase().then((value)async{
      List<SendItem> list = await queryAll(value);
      sendMoneyList.assignAll(list);
      int mouthSendSum = await getThisMounthSend(value);
      mouthSend.value = mouthSendSum;
      int daySendSum = await getNowDaySend(value);
      daySend.value = daySendSum;

      int buySend = await getThisMounthBySend(value,'buy');
      int lifeSend = await getThisMounthBySend(value,'life');
      int playSend = await getThisMounthBySend(value,'play');
      int eatSend = await getThisMounthBySend(value,'eat');
      sendTypeMap.value = [
        SendType('购物消费', buySend, Icons.shopping_cart_outlined),
        SendType('吃饭消费', eatSend, Icons.restaurant_menu_outlined),
        SendType('生活消费', lifeSend, Icons.nightlife_outlined),
        SendType('娱乐消费', playSend, Icons.sports_esports_outlined),
      ];
      value.close();
    });
  }
  @override
  void initState(){
    updatePageData();
  }

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
                  child: ListTile(
                    leading: const Icon(Icons.today),
                    title: Obx(()=>Text('今日消费: ${daySend.value.toString()}', style: TextStyle(fontSize: 15))),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: ListTile(
                    leading:const Icon(Icons.thirty_fps_outlined),
                    title: Obx(()=>Text('本月消费: ${mouthSend.value.toString()}', style: TextStyle(fontSize: 15))),
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
                        onTap:  () async {
                          var back =await Get.toNamed('/addSendItem');
                          updatePageData();
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
                          height: 100,
                          child:Obx(()=> GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              children: sendTypeMap.value.map<Widget>((e) {
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
                              }).toList())))
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
                  content:Obx(()=> ListView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: sendMoneyList
                          .map<Widget>((e) => Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              width: MediaQuery.of(context).size.width * 0.94,
                              height: 50,
                              child: ListTile(
                                leading: Icon(getSendType(e.type).icon),
                                title: Text(getSendType(e.type).name),
                                subtitle:Text('花费:${e.money.toString()}') ,
                                trailing:Text(new DateTime.fromMicrosecondsSinceEpoch(e.date * 1000).toString().substring(0,10)),
                              )))
                          .toList()))),
            ],
          ),
        )));
  }
}
