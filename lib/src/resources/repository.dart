import 'dart:async';
import 'package:news/src/model/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository{
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  Future<List<int>> fetchTopIds(){
    return apiProvider.fetchTopIds();
  }
  Future<ItemModel> fetchItem(int id) async {
    //이전에 fetch 한적있나 device db에서 확인
    var item = await dbProvider.fetchItem(id);
    if(item!=null){
      return item; //있으면 리턴
    }
    //없으면 데려옴
    item =  await apiProvider.fetchItem(id);
    //db에추가
    dbProvider.addItem(item);
    return item;
  }
}