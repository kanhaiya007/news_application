import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:newsapplication/model/responseNews/NewsResponse.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static final String _baseUrl = 'https://newsapi.org/v2/top-headlines?';
  static final String _apiId = "&apiKey=YOUR_API_KEY";
  static NewsResponse newsResponse = new NewsResponse();

  // http request to fetch the news from the API, sources and Indian News are displayed only.
  static Future<NewsResponse> getApiNews(String name) async {
    String newUrl = name == null
        ? "${_baseUrl}country=in$_apiId"
        : "${_baseUrl}sources=$name$_apiId";
    final response = await http.get(newUrl);
    if (response.statusCode == 200) {
      newsResponse = NewsResponse.fromJsonMap(jsonDecode(response.body));
      debugPrint(newsResponse.articles[0].source.name);
      return newsResponse;
    } else {
      return null;
    }
  }
}
