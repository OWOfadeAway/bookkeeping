import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../state/type.dart';
import '../compotens/NumberFeild.dart';

class AddSendItem extends StatefulWidget {
  const AddSendItem({super.key});
  @override
  State<AddSendItem> createState() => _AddSendItem();
}

class _AddSendItem extends State<AddSendItem> {
  // SendType('吃饭消费', 50, Icons.restaurant_menu_outlined),
  //   SendType('生活消费', 50, Icons.nightlife_outlined),
  //   SendType('娱乐消费', 50, Icons.sports_esports_outlined),
  RxInt selectIndex = 0.obs;
  TextEditingController _textController = TextEditingController();
  // ignore: non_constant_identifier_names
  InputBorder Border = const OutlineInputBorder(
    /*边角*/
    borderRadius: BorderRadius.all(
      Radius.circular(10), //边角为30
    ),
    borderSide: BorderSide(
      color: Colors.blue, //边线颜色为黄色
      width: 2, //边线宽度为2
    ),
  );
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
                  height: 100,
                  // padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(227, 242, 253, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: typeList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                              crossAxisCount: 4,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return Obx(() => GestureDetector(
                            onTap: () {
                              selectIndex.value = index;
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: index.obs == selectIndex
                                        ? Color.fromARGB(255, 255, 161, 98)
                                        : const Color.fromARGB(0, 0, 0, 0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      typeList[index].icon,
                                      size: 40,
                                      color: Colors.redAccent[400],
                                    ),
                                    Text(
                                      typeList[index].name,
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                )))));
                      }),
                ),
                const Text(
                  "请输入消费金额:",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _textController,
                  inputFormatters: [AmountTextFieldFormatter()],
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: Border,
                    enabledBorder: Border,
                    fillColor: Color.fromARGB(255, 251, 254, 255),
                    hintText: '请输入花费的金额',
                    prefixIcon: Icon(Icons.monetization_on_rounded),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Center(
                  child: IconButton(
                    icon: const Icon(Icons.send,size: 80,),
                    onPressed: () {
                      
                      // 按钮点击时执行的操作
                      // ignore: avoid_print
                      print('IconButton was pressed');
                    }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
