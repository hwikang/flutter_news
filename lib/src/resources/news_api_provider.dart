import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/model/item_model.dart';
//
final root = "https://hacker-news.firebaseio.com/v0/";
class NewsApiProvider{
  
  Client client = Client();
  Future<List<int>> fetchTopIds() async{
    final res = await client.get("${root}topstories.json");
    //cast- copy of list 타입이 정확하게나오는 리스트, 
    final ids = json.decode(res.body);
    return ids.cast<int>();
  }
  Future<ItemModel> fetchItem(int id) async{
    final res = await client.get("${root}item/$id.json") ;
    print(res.body);
    final parsedJson = json.decode(res.body);
    print(parsedJson);
    return ItemModel.fromJson(parsedJson);
  }
}