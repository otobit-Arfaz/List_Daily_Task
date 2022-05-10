import 'package:get/get.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/models/category.dart';

class CategoryController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var categList= <Category>[].obs;

  Future<int> addCategory({Category? category}) async {
    return await DBHelper.insert(category);
  }

  // get all the data from table
void getCategories() async{
    List<Map<String, dynamic>> categories = await DBHelper.query();
    print(categories[0]);
    // print(categories[0]['id'].runtimeType);
    // print(categories[0]['cat'].runtimeType);
    // print(categories[0]['description'].runtimeType);
    // print(categories[0]['date'].runtimeType);
    // print(categories[0]['isCompleted'].runtimeType);
    // print(categories[0]['color'].runtimeType);
    // categories.map((data)=>{
    //   print(Category.fromJson(data))
    //   // Category.fromJson(data)
    // }).toList();
    categList.assignAll(categories.map((data)=> new Category.fromJson(data)).toList());
}

void delete(Category category){
   DBHelper.delete(category);
   getCategories();
  // print(val);
}
void markCategoryWatched(int id)async{
    await DBHelper.update(id);
    getCategories();
}

}