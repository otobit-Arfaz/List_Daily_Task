 import 'package:flutter/foundation.dart';
class Category{
  int? id;
  String? cate;
  String? description;
  int? isCompleted;
  String? date;
  int? color;

Category({
   this.id,
 this.cate,
 this.description,
 this.isCompleted,
 this.date,
 this.color
 });

Category.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  cate = json['cat'];
 description = json['description'];
 isCompleted = json['isCompleted'];
 date = json['date'];
 color = json['color'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['cat'] = this.cate;
  data['date'] = this.date;
  data['description'] = this.description;
  data['isCompleted'] = this.isCompleted;
  data['color'] = this.color;
 return data;

 }
 }