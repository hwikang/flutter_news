import 'dart:async';
import 'package:news/src/model/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository{
  // NewsApiProvider apiProvider = NewsApiProvider();
  // NewsDbProvider dbProvider = NewsDbProvider();
  
  List<Source> sources = <Source>[
    NewsApiProvider(),
     NewsDbProvider()
  ];
  List<Cache> caches = <Cache>[
    NewsDbProvider()
  ];

  Future<List<int>> fetchTopIds(){
    //
    // return apiProvider.fetchTopIds();
  }
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for(source in sources){
      item = await source.fetchItem(id);
      if(item!=null){
        break;
      }
    }
    for(var cache in caches){
      cache.addItem(item);
      
    }
    return item;
    
    // //이전에 fetch 한적있나 device db에서 확인
    // var item = await dbProvider.fetchItem(id);
    // if(item!=null){
    //   return item; //있으면 리턴
    // }
    // //없으면 데려옴
    // item =  await apiProvider.fetchItem(id);
    // //db에추가
    // dbProvider.addItem(item);
    // return item;
  }
}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}
abstract class Cache{
  Future<int> addItem(ItemModel model);
}
