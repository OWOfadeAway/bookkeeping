import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddSendItem extends StatefulWidget{
  const AddSendItem({super.key});
  @override
  State<AddSendItem> createState() =>_AddSendItem();

}
class _AddSendItem extends State<AddSendItem>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:AppBar(
          title: Text('记一笔'),
        ),
        body: Column(
            children: [
              Container(
                padding:const EdgeInsets.all(10.0),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("请选择消费类型:",style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: GridView.builder(
                          itemCount:5,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                          crossAxisCount: 4,
                          // //纵轴间距
                          // mainAxisSpacing: ScreenUtil().setHeight(10),
                          // // 横轴间距
                          // crossAxisSpacing: ScreenUtil().setWidth(10),
                          //子组件宽高长度比例
                          childAspectRatio: 1), itemBuilder: (context, index) {
                        print(index);
                              return Text("123");
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