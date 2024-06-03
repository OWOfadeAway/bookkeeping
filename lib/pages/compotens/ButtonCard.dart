/*
 * @Description: 
 * @Author: jxh
 * @Date: 2024-05-25 14:46:18
 * @LastEditTime: 2024-05-27 08:39:22
 * @LastEditors: jxh
 */
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onTap;
  ButtonCard(
      {Key? key,
      required this.backgroundColor,
      required this.icon,
      required this.text,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: backgroundColor),
          height: 80,
          width: MediaQuery.of(context).size.width / 2.3,
          child: InkWell(
            borderRadius:const BorderRadius.all(Radius.circular(20.0)),
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Icon(icon, color: color, size: 45.0)
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      text,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 247, 244, 244),
                          fontSize: 20,
                          letterSpacing: 5.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                    )),
              ],
            ),
          ),
        ));
  }
}
