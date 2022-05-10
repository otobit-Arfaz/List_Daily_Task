import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/category_controller.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/input_field.dart';

import '../models/category.dart';
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final CategoryController _categoryController = Get.put(CategoryController());
  final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _categories = "none";
  // List<String> CategoryList=[
  //   'cartoon',
  //   'food',
  //   'Toys',
  // ];
  int _selectedColor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  "Add Categories",
                style: headingStyle,
                ),
              MyInputField(cat: "Category", hint: "Enter Your Category",controller: _CategoryController,
              // widget: DropdownButton(
              //   icon: Icon(Icons.keyboard_arrow_down,
              //   color: Colors.grey,
              //   ),
              //   iconSize: 32,
              //   elevation: 4,
              //   style: subCategoryStyle,
              //   items:CategoryList.map<DropdownMenuItem<String>>((String value){
              //     return DropdownMenuItem<String>(
              //       value: value.toString(),
              //       child: Text(value.toString()),
              //     );
              //   }
              //   ).toList(), onChanged: (String? newvalue) { CategoryList = String.parse(newvalue); },
              // ),
              ),
              MyInputField(cat: "Description", hint: "Enter Your Details",controller: _DescriptionController,),
              MyInputField(cat: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(onPressed: (){_getDateFromUser();}, icon: Icon(Icons.calendar_today_outlined,
              color: Colors.grey,)),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(
                      label: "Create Ctegory", onTap: ()=>_validateDate())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addCategoryTodb() async {
   int value = await _categoryController.addCategory(
        category:Category(
          description: _DescriptionController.text,
          cate: _CategoryController.text,
          date: DateFormat.yMd().format(_selectedDate),
          color: _selectedColor,
          isCompleted: 0,
        )
    );
    print("My id is"+"$value");
  }

  _validateDate(){
    if(_CategoryController.text.isNotEmpty&&_DescriptionController.text.isNotEmpty){
      //add to database
      _addCategoryTodb();

      Get.back();


    }else if(_CategoryController.text.isEmpty|| _DescriptionController.text.isEmpty){
      Get.snackbar("Required", "All fields are required",
      snackPosition: SnackPosition.BOTTOM,
        colorText: hashClr,
        backgroundColor: bluishClr,
        icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }
  _colorPallete(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
            style: subCategoryStyle),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor=index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?primaryClr:index==1?yellowClr:hashClr,
                      child: _selectedColor==index?Icon(Icons.done,
                        color: Colors.blueAccent,
                        size: 16,):Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
  _appBar() {
    return AppBar(
      title: Text('List Your Categories'),
      leading: GestureDetector(
        onTap: () {
            Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
            size: 23),
      ),
      actions: [
        Icon(Icons.person, size: 23),
        SizedBox(
          width: 23,
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2122));
    if(_pickerDate!=null){
setState(() {
  _selectedDate = _pickerDate;
  print(_selectedDate);

});    }else{
      print("It's null or something is wrong");
    }
  }
}
