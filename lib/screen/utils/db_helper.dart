import 'package:budgt_trocker/screen/category/model/category_model.dart';
import 'package:budgt_trocker/screen/entry/model/entry_model.dart';
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
        String query = "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
        String query1 = "CREATE TABLE entry (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,amount TEXT,category TEXT,date TEXT,time TEXT,status INTEGER)";
        db.execute(query);
        db.execute(query1);

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

  Future<void> insertIncameExpens(title,date,category,time,amount,status) async {
    database = await checkDB();
    String query = "INSERT INTO entry (title,amount,category,date,time,status) VALUES ('$title','$amount','$category','$date','$time','$status')";
    database!.rawInsert(query);
  }

  Future<List<EntryModel>> readEntry()
  async {
    database=await checkDB();
    String query="SELECT * FROM entry";
    List<Map> l1 = await database!.rawQuery(query);
    List<EntryModel> entryList=l1.map((e) => EntryModel.MapToModel(e),).toList();
    return entryList;


  }
  Future<void> deleteEntry(int? id)
  async {
    database = await checkDB();
    String query = " DELETE FROM entry WHERE id ='$id'";
    database!.rawDelete(query);
  }
  Future<void> updateEntry(String title,String amount,String time,String category,String date,String status, int id) async {
    database = await checkDB();
    String query = "UPDATE entry SET title='$title',amount='$amount',time='$time',category='$category',date='$date',status='$status' WHERE cid='$id'";
    database!.rawUpdate(query);
  }
}
