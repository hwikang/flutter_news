// import 'package:flutter_test/flutter_test.dart'
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test_api/test_api.dart';

import 'package:http/http.dart';
import 'package:http/testing.dart';
void main(){
  test('FetchTopId return',() async {
    
    //setup test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1,2,3,4]),200); //response로바꾸고 200코드보냄
    }); //client for testing
    final ids = await newsApi.fetchTopIds();
    //expectation
    expect(ids, [1,2,3,4]);
  });
  test('FetchItem return',() async{
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final map = {"id":123};
      return Response(json.encode(map),200);
    });
    final item = await newsApi.fetchItem(999);
    print(item);
    expect(item.id,123);
  });
}
