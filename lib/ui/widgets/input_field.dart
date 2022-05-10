import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String cat;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {Key? key,
      required this.cat,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cat,
            style: categoryStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: subCategoryStyle,
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subCategoryStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0))),
                  ),
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
