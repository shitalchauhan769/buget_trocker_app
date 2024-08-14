import 'package:budgt_trocker/screen/utils/db_helper.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';

class CategoryController extends GetxController
{
   DBHelper helper =DBHelper();
   RxList<CategoryModel>categoryList=<CategoryModel>[].obs;

   Future<void> getCategory() async {
     categoryList.value= await helper.readCategory();
   }
}