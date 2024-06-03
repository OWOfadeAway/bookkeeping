import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../state/type.dart';

class AddSendItem extends StatefulWidget {
  const AddSendItem({super.key});
  @override
  State<AddSendItem> createState() => _AddSendItem();
}

class _AddSendItem extends State<AddSendItem> {
  // SendType('吃饭消费', 50, Icons.restaurant_menu_outlined),
  //   SendType('生活消费', 50, Icons.nightlife_outlined), 
  //   SendType('娱乐消费', 50, Icons.sports_esports_outlined),
  RxInt selectIndex = 999.obs; 
  @override
  Widget build(BuildContext context) { 
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(120, 194, 255, 1),
        title: Text('记一笔'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "请选择消费类型:",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(227, 242, 253, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: GridView.builder(
                      itemCount: typeList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                              crossAxisCount: 4,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap:()=>{selectIndex = index.obs},
                          child:Container(
                            decoration: BoxDecoration(
                              color: index == selectIndex? Colors.redAccent[400] :const Color.fromARGB(0, 0, 0, 0),
                              borderRadius: const BorderRadius.all(Radius.circular(20.0))
                            ),
                            child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      typeList[index].icon,
                                      size: 40,
                                      color: Colors.redAccent[400],
                                    ),
                                    Text(
                                      typeList[index].name,
                                      style: const TextStyle(),
                                    )
                                  ],
                                ))));
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
