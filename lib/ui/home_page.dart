import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/category_controller.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/add_task_bar.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addDateBar(),
          _addTaskBar(),
          SizedBox(
            height: 10,
          ),
          _showCategories(),
        ],
      ),
    );
  }

  _showCategories() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _categoryController.categList.length,
            itemBuilder: (_, index) {
                Category category = _categoryController.categList[index];
                print(category.toJson());
                if(category.date==DateFormat.yMd().format(_selectedDate)){
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showButtonSheet(context,
                                      category);
                                },
                                child: CategoryTile(
                                    category),
                              )
                            ],
                          ),
                        ),
                      ));
                }else{
                  return Container();
                }

            });
      }),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(

            // margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            Text(
              "Today",
              style: headingStyle,
            ),
          ],
        )),
        MyButton(
            label: "+ Add Category",
            onTap: () async {
              await Get.to(() => AddTaskPage());
              _categoryController.getCategories();
            })
      ]),
    );
  }

  _showButtonSheet(BuildContext context, Category category) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: category.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? Colors.white10 : Colors.black12,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
          Spacer(),
          category.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Watched",
                  onTap: () {
                    _categoryController.markCategoryWatched(category.id!);
                    Get.back();
                  },
                  clr: hashClr,
                  context: context,
                ),
          // SizedBox(height: 20,),
          _bottomSheetButton(
            label: "Delete Category",
            onTap: () {
              _categoryController.delete(category);
              Get.back();
            },
            clr: pink,
            context: context,
          ),
          // SizedBox(height: 20,),
          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: Colors.white,
            isClose: true,
            context: context,
          )
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border:
              Border.all(width: 2, color: isClose == true ? Colors.white : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? categoryStyle
                : categoryStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: Text('List Your Categories'),
      leading: GestureDetector(
        onTap: () {
          ThemeSevices().switchTheme();
        },
        child: Icon(Icons.nightlight_round, size: 23),
      ),
      actions: [
        Icon(Icons.person, size: 23),
        SizedBox(
          width: 23,
        )
      ],
    );
  }
}
