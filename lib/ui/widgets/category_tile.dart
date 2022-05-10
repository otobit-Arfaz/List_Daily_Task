import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/category.dart' as Categ;
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class CategoryTile extends StatelessWidget {
  final Categ.Category? category;
  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
      // width:SizeConfig.screenWidth*0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(category?.color??0),

        ),
        child: Row(children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category?.cate??"",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),

                ),
              ),
              SizedBox(height: 12,),
              Text(
                category?.date??"",
                style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15,
                      color: Colors.black,)
                ),
              ),

                SizedBox(height: 12,),
              Text(
                category?.description??"",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 15,
                  color: Colors.grey[100],)
                ),

              )
            ],
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(quarterTurns: 3,child: Text(
            category!.isCompleted == 1 ? "WATCHED":"CATEGORY",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),)
        ],),
      ),

    );
  }

  _getBGClr(int no){
    switch(no){
      case 0:
        return bluishClr;
      case 1:
        return yellowClr;
      case 2:
        return hashClr;
      default:
        return bluishClr;
    }
  }
}
