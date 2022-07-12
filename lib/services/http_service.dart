import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:pinterest/models/pinterest_data.dart';

class HttpService {
  static bool isTester = true;

  /// Base URL
  static String SERVER_DEVELOPMENT = 'api.unsplash.com';
  static String SERVER_PRODUCTION = 'api.unsplash.com';

  /// Server
  static String getServer() {
    return isTester ? SERVER_DEVELOPMENT : SERVER_PRODUCTION;
  }

  /// Http APIs
  static String API_LIST = "/photos";
  static String API_SEARCH_LIST = "/search/photos";

  /// Header
  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      'Accept-Version': 'v1',
      'Authorization':'Client-ID _CF1t7eMK9M3FbgBNupTRVoAALKOAMGY493unkq9La4'
      // 'Authorization':'Client-ID zYGJr9DhtNKBrx-M5SL9b4QJe3j9kxXlYQtZVB10st8'
    };
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json; charset=UTF-8'
    // };
    return headers;
  }

  /// Http Requests Methods
  static Future<List<Pinterest>> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    Response response = await get(uri, headers: getHeaders());

    if (response.statusCode == 200){
      return api == API_SEARCH_LIST ? compute(parseSearchPost, response.body) : compute(parsePost, response.body);
    }
    else if(response.statusCode == 404){
      throw Exception('Not Found');
    }
    else{
      throw Exception('Can\'t get post');
    }
  }

  // static Future<String?> POST(String api, Map<String, String> body) async {
  //   var uri = Uri.https(getServer(), api); // http or https
  //   Response response = await post(uri, headers: getHeaders(), body: jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return response.body;
  //   }
  //   return null;
  // }

  // static Future<String?> PUT(String api, Map<String, String> body) async {
  //   var uri = Uri.https(getServer(), api); // http or https
  //   Response response = await put(uri, headers: getHeaders(), body: jsonEncode(body));
  //
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  // static Future<String?> PATCH(String api, Map<String, String> body) async {
  //   var uri = Uri.https(getServer(), api); // http or https
  //   Response response = await patch(uri, headers: getHeaders(), body: jsonEncode(body));
  //
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  // static Future<String?> DELETE(String api, Map<String, String> body) async {
  //   var uri = Uri.https(getServer(), api, body); // http or https
  //   Response response = await delete(uri, headers: getHeaders());
  //
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  /// Http Parameters
  static Map<String, dynamic> paramsGET({int page = 1, String sortBy = 'popular'}) {
    Map<String, String> params = {};
    params.addAll({
      "page": page.toString(),
      'per_page': '20',
      'order_by': sortBy
    });
    return params;
  }
  static Map<String, dynamic> paramsSearch({int page = 1, int perPage = 20, required String topic}) {
    Map<String, String> params = {};
    params.addAll({
      "page": page.toString(),
      'per_page': perPage.toString(),
      'query': topic
    });
    return params;
  }

  /// Http Parsing
  static List<Pinterest> parsePost(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Pinterest> posts = list.map((model) => Pinterest.fromJson(model)).toList();
    return posts;
  }

  static List<Pinterest> parseSearchPost(String responseBody) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<Pinterest> photos = List<Pinterest>.from(json["results"].map((x) => Pinterest.fromJson(x)));
    return photos;
  }
}
