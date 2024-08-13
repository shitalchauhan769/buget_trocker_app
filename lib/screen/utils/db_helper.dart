import 'package:budgt_trocker/screen/category/model/category_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? database;

  Future<Database> checkDB() async {
    if (database == null) {

      database = await initDB();
    }
    return database!;
  }

  Future<Database> initDB() async {

    String folder = await getDatabasesPath();
    String path = "$folder/demo.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
        db.execute(query);

      },
    );
  }

  Future<void> insertCategory(String category) async {
    database = await checkDB();
    String query = "INSERT INTO category (name) VALUES ('$category')";
    database!.rawInsert(query);
  }

  Future<List<CategoryModel>> readCategory() async {
    database = await checkDB();
    String query = "SELECT * FROM category";
     List<Map> l1 =await database!.rawQuery(query);
    List<CategoryModel> categoryList = l1.map((e) => CategoryModel.MapToModel(e),).toList();

    return categoryList;

  }

  Future<void> updateCategory(String name, int id) async {
    database = await checkDB();
    String query = "UPDATE category SET name='$name' WHERE cid='$id'";
    database!.rawUpdate(query);
  }

  Future<void> deleteCategory(int id ) async {
    database = await checkDB();
    String query = "DELETE FROM category WHERE cid='$id'";
    database!.rawDelete(query);
  }
}
