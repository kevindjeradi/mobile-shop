import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_cash_manager/shared/constants.dart';
import 'package:mobile_cash_manager/utils/utils.dart';

class ArticleApi {
  static Future<Response> createArticle(Map<String, dynamic> payload) async =>
      client.post(Utils.withBaseUrl("/create", ApiRouteType.articles),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(payload));

  static Future<Response> updateArticle(Map<String, String> payload) async =>
      client.put(Utils.withBaseUrl("/", ApiRouteType.articles), body: payload);

  static Future<Response> getAllArticles() async {
    return client.get(Utils.withBaseUrl("/", ApiRouteType.articles));
  }

  static Future<Response> getArticleByBarcode(String barcode) async {
    return client.get(
        Utils.withBaseUrl("/getByBarcode/$barcode", ApiRouteType.articles));
  }

  static Future<Response> getById(int id) async {
    return client.get(Utils.withBaseUrl("/getbyId/$id", ApiRouteType.articles));
  }

  static Future<Response> deleteWithId(int id) async =>
      client.delete(Utils.withBaseUrl("/$id", ApiRouteType.articles));
}
