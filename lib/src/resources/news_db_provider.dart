import 'package:news/src/model/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class NewsDbProvider implements Source,Cache {
  Database db;

  void init() async{
    //dart.io 
    Directory documentDirectory = await getApplicationDocumentsDirectory();
      //  database경로
    final path = join(documentDirectory.path,"items.db");
    //path 에 db가없으면 깔아준다. 있으면 열기만함
    db = await openDatabase(
      path,
      version:1,  //스키마바꾸면 버전업
      onCreate:(Database newDb,int version){ //테이블 스키마
        newDb.execute("""
          CREATE TABLE Items(
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async{
    final maps = await db.query(
      "Items",  //table name
      columns: null,  //원하는 컬럼, 딱히없으면 null
      where : "id=?",  //조건문
      whereArgs: [id],
    );

    if(maps.length>0){
      return ItemModel.fromDb(maps.first); // map 형태의 걀과값을 모델타입 으로 바꿈
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap()
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }
}