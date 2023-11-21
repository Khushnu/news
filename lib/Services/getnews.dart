import 'package:dio/dio.dart';
import 'package:news/Models/categoriesmodel.dart';
import 'package:news/Models/countrynewsmodel.dart';
import 'package:news/Models/newsmodel.dart';
import 'package:news/Services/httpservices.dart';


class GetNewsModel{
  bool isLoaded = false;
  final dio = Dio(); 
 Future<NewsClass> getNews(String sources)async{
   final url = 'https://newsapi.org/v2/top-headlines?sources=$sources&apiKey=${HttpServices.apikey}';
  var response = await dio.get(url); 
  if(response.statusCode == 200){
    var data = response.data;
    isLoaded = true;
   return NewsClass.fromJson(data);
  }
 throw Exception('Error');
}


 Future<CountryNewsModel> getNewsByCountry(String country)async{
  final url = 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=${HttpServices.apikey}';
  var response = await dio.get(url); 
  if(response.statusCode == 200){
    var data = response.data;
    isLoaded = true;
   return CountryNewsModel.fromJson(data);
  }
 throw Exception('Error');
}


 Future<CategoriesClass> getCatergories(String query, )async{
    final everythingNews = 'https://newsapi.org/v2/everything?q=$query&apiKey=${HttpServices.apikey}';
  var response = await dio.get(everythingNews); 
  if(response.statusCode == 200){
    var data = response.data;
    print(data);
   return CategoriesClass.fromJson(data);
    // isLoaded = true;
  }
 throw Exception('Error');
}



}