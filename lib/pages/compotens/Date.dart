// ignore: file_names
// 参考博客 https://blog.csdn.net/qq_22492233/article/details/121678380
import 'package:flutter/material.dart';
class Dates extends StatefulWidget{
  const Dates({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dates();
  }

}

class _Dates extends State<Dates> {
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;
  final List<CalendarModel> _datas = [];
  // ignore: non_constant_identifier_names, prefer_final_fields
  List<CalendarModel> _list_datas = [];
  @override
  void initState(){
    // TODO: implement initState
    //设置默认当前月日期
    _setDatas(year: _year, month: _month);
 
    //设置模拟数据，日历月事件，可根据接口返回的结果
    // ignore: prefer_interpolation_to_compose_strings
    _loadAttendanceMonthRecord( _year.toString() + "-" + _month.toString());
    //日历日事件
    // ignore: prefer_interpolation_to_compose_strings
    // _loadAttendanceDayRecord(_year.toString() + "-" + _month.toString()+"-"+_day.toString());
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
              margin: EdgeInsets.all(20),
              decoration:const BoxDecoration(
                //设置颜色
                borderRadius: BorderRadius.all(Radius.circular(12)),
                //设置四周边框
              ),
              child: Column(
                children: [
                  // _yearHeader(),
                  _weekHeader(),
                  _everyDay(),
                ],
              ),
            );
  }
  //底部日
  Widget _everyDay() {
    return Container(
      child: GridView.builder(
        padding:const EdgeInsets.only(left: 0, top: 0, right: 0),
        itemCount: _getRowsForMonthYear(year: _year, month: _month) * 7,
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 7,
            // //纵轴间距
            // mainAxisSpacing: ScreenUtil().setHeight(10),
            // // 横轴间距
            // crossAxisSpacing: ScreenUtil().setWidth(10),
            //子组件宽高长度比例
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_datas[index].month == _month) {
                  //判断点击的是否是当月日期，只对当前月点击的日期做处理
                  for (int i = 0; i < _datas.length; i++) {
                    if (i == index) {
                      //切换至选中的日期
                      _day = _datas[i].day!;
                      _datas[i].is_select = true;
 
                      //加载选中的日期事件
                      _loadAttendanceDayRecord( _datas[i]);
                    } else {
                      _datas[i].is_select = false;
                    }
                  }
                } else {
                  //不是当月的不做处理
                  // _datas[index].is_select=false;
                }
              });
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    //设置底部背景
                    decoration: _datas[index].is_select!
                        ?const BoxDecoration(
                      shape: BoxShape.circle,
                    )
                        :const BoxDecoration(),
                    child: Center(
                      child: Text(
                        //不是当前月不显示值
                        _datas[index].month == _month
                            ? _datas[index].day.toString()
                            : "",
                        //设置选中字体颜色，以及周末和工作日颜色
                        style: _datas[index].is_select!
                            ? const TextStyle(
                                fontSize: 16, color: Color.fromARGB(221, 0, 157, 255))
                            : (index % 7 == 5 || index % 7 == 6
                                ?const TextStyle(
                                    fontSize: 16, color: Color.fromARGB(221, 255, 145, 42))
                                :const TextStyle(
                                    fontSize: 16, color: Colors.black87)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  //设置底部小圆点，非当前月的不显示，设置为透明，其余的根据状态判断显示
                  _datas[index].month == _month &&
                          _datas[index].sendMoney != "" &&
                          _datas[index].sendMoney != "0"
                      ? Container(
                          // height: 6.0,
                          // width: 6.0,
                          decoration:const BoxDecoration(
                              shape:  BoxShape.circle,
                              ),
                          child: Text(_datas[index].sendMoney as String,style: TextStyle(color: Color.fromARGB(255, 255, 64, 105),fontSize: 12),),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //中部周
  Widget _weekHeader() {
    var array = ["一", "二", "三", "四", "五", "六", "日"];
    return SizedBox(
      height: 20,
      child: GridView.builder(
        padding:const EdgeInsets.only(left: 0, right: 0),
        itemCount: array.length,
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 7,
            //纵轴间距
            // mainAxisSpacing: ScreenUtil().setHeight(10),
            // 横轴间距
            // crossAxisSpacing: ScreenUtil().setWidth(15),
            //子组件宽高长度比例
            childAspectRatio: 2),
        itemBuilder: (context, index) {
          return Container(
              alignment: Alignment.center,
              child: Text(
                array[index],
                style: TextStyle(
                    color: index == 5 || index == 6
                        ? Colors.black87
                        : Colors.black87,
                    fontSize: 13),
              ));
        },
      ),
    );
  }
  //头部年
  Widget _yearHeader() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _lastMonth();
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
            ),
          ),
          Text(
            "$_year 年$_month 月",
            style: TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              _nextMonth();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
            ),
          ),
        ],
      ),
    );
  }
   // 上月
  _lastMonth() {
    setState(() {
      if (_month == 1) {
        _year = _year - 1;
        _month = 12;
      } else {
        _month = _month - 1;
      }
      _day = 1; //查看上一个月时，默认选中的为第一天
      _datas.clear();
      _setDatas(year: _year, month: _month);
      //更新月历事件
      _loadAttendanceMonthRecord( _year.toString() + "-" + _month.toString());
      //更新日事件
      // _loadAttendanceDayRecord(_year.toString() + "-" + _month.toString()+"-"+_day.toString());
    });
  }
  _nextMonth() {
     if(_month==12){//当前月是12月，下一个月就是下一年
      if(DateTime.now().year>=_year+1){//判断下一年是否大于当前年
        _setNextMonthData();
      }
    }else{//当前月不是12月，还处于当前年
      if(DateTime.now().month>=_month+1){
        //判断下一个月是否超过当前月，超过当前月不做操作
        _setNextMonthData();
      }
    }
  }
  // 获取行数
  int _getRowsForMonthYear({int? year, int? month}) {
    //当前月天数
    var _currentMonthDays = _getCurrentMonthDays(year: year, month: month);
    //
    var _placeholderDays = _getPlaceholderDays(year: year, month: month);
 
    int rows = (_currentMonthDays + _placeholderDays) ~/ 7;
 
    int remainder = (_currentMonthDays + _placeholderDays) % 7;
    if (remainder > 0) {
      rows = rows + 1;
    }
    return rows;
  }

  _loadAttendanceDayRecord(CalendarModel calendarModel) async{
    //可根据接口返回的内容在日历下面打卡信息或者其余内容
    print("点击的是"+calendarModel.month.toString()+calendarModel.day.toString()+'花费是'+calendarModel.sendMoney);
  }
  //加载月历事件，请求接口
  _loadAttendanceMonthRecord(String dateTime) async {
    CalendarModel bean1=  CalendarModel(year: _year,month: _month,day: 1,sendMoney: "4");
    CalendarModel bean2=  CalendarModel(year: _year,month: _month,day: 2,sendMoney: "4");
    CalendarModel bean3=  CalendarModel(year: _year,month: _month,day: 3,sendMoney: "2");
    CalendarModel bean4=  CalendarModel(year: _year,month: _month,day: 4,sendMoney: "6");
    CalendarModel bean5=  CalendarModel(year: _year,month: _month,day: 5,sendMoney: "3");
    CalendarModel bean6=  CalendarModel(year: _year,month: _month,day: 6,sendMoney: "4");
    _list_datas.add(bean1);
    _list_datas.add(bean2);
    _list_datas.add(bean3);
    _list_datas.add(bean4);
    _list_datas.add(bean5);
    _list_datas.add(bean6);

    setState(() {
      for (int i = 0; i < _datas.length; i++) {
        for (int j = 0; j < _list_datas.length; j++) {
          if (_datas[i].year== _list_datas[j].year &&
              _datas[i].month == _list_datas[j].month &&
              _datas[i].day == _list_datas[j].day) {
            _datas[i].sendMoney = _list_datas[j].sendMoney;
          }
        }
      }

    });
  }

  // 得到这个月的第一天是星期几
   int _getPlaceholderDays({int? year, int? month}) {
    return DateTime(year!, month!).weekday - 1 % 7;
  }
  // 获取当前月份天数
  int _getCurrentMonthDays({int? year, int? month}) {
    if (month == 2) {
      //判断2月份是闰年月还是平年
      if (((year! % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        return 29;
      } else {
        return 28;
      }
    } else if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      return 31;
    } else {
      return 30;
    }
  }

  /// 获取展示信息
  _setDatas({int? year, int? month}) {
    /// 上个月占位
    var lastYear = year;
    var lastMonth = month! - 1;
    if (month == 1) {
      lastYear = year! - 1;
      lastMonth = 12;
    }
 
    var placeholderDays = _getPlaceholderDays(year: year, month: month);
    var lastMonthDays = _getCurrentMonthDays(year: lastYear, month: lastMonth);
    var firstDay = lastMonthDays - placeholderDays;
    for (var i = 0; i < placeholderDays; i++) {
      _datas.add(CalendarModel(
          year: lastYear!,
          month: lastMonth,
          day: firstDay + i + 1,
          is_select: false,
          sendMoney: ""));
    }
    /// 本月显示
    var currentMonthDays = _getCurrentMonthDays(year: year, month: month);
    for (var i = 0; i < currentMonthDays; i++) {
      if (i == _day - 1) {
        _datas.add(CalendarModel(
            year: year!,
            month: month,
            day: i + 1,
            is_select: true,
            sendMoney: ""));
      } else {
        _datas.add(CalendarModel(
            year: year!,
            month: month,
            day: i + 1,
            is_select: false,
            sendMoney: ""));
      }
    } 
    /// 下个月占位
    var nextYear = year;
    var nextMonth = month + 1;
    if (month == 12) {
      nextYear = year! + 1;
      nextMonth = 1;
    }
    var nextPlaceholderDays =
        _getPlaceholderDays(year: nextYear, month: nextMonth);
    for (var i = 0; i < 7 - nextPlaceholderDays; i++) {
      _datas.add(CalendarModel(
          year: nextYear!,
          month: nextMonth,
          day: i + 1,
          is_select: false,
          sendMoney: ""));
    }
  }
  _setNextMonthData(){
    setState(() {
      if (_month == 12) {
        _year = _year + 1;
        _month = 1;
      } else {
        _month = _month + 1;
      }
      if (_month == DateTime.now().month) {
        //如果下个月时当前月，默认选中当天
        _day = DateTime.now().day;
      } else {
        //如果不是当前月，默认选中第一天
        _day = 1;
      }
      _datas.clear();
      _setDatas(year: _year, month: _month);
      //更新月历事件
      _loadAttendanceMonthRecord( _year.toString() + "-" + _month.toString());
      //更新日事件
      // _loadAttendanceDayRecord(_year.toString() + "-" + _month.toString()+"-"+_day.toString());
    });
  }
}
// 日历对象
class CalendarModel {
  int? year;
  int? month;
  int? day;
  String sendMoney = "";//日期事件，0，休息，1，异常，2，正常
  bool? is_select = false;
 
  CalendarModel(
      {this.year, this.month, this.day, this.is_select, this.sendMoney=''});
}