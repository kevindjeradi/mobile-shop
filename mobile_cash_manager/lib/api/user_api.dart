import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_cash_manager/shared/constants.dart';
import 'package:mobile_cash_manager/utils/utils.dart';

class UserApi {
  static Future<Response> createUser(Map<String, dynamic> payload) async =>
      client.post(Utils.withBaseUrl("/register", ApiRouteType.users),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(payload));

  static Future<Response> login(
          {required String email, required String password}) async =>
      client.post(Utils.withBaseUrl("/login", ApiRouteType.users),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email, "password": password}));

  static Future<Response> addCard({
    required String email,
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
    required String cardHolder,
  }) async =>
      client.post(Utils.withBaseUrl("/addCard", ApiRouteType.users),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvvCode": cvvCode,
            "cardHolder": cardHolder,
          }));

  static Future<Response> updateSolde({
    required String email,
    required double solde,
    required String type,
  }) async =>
      client.post(Utils.withBaseUrl("/addSolde", ApiRouteType.users),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "type": type,
            "email": email,
            "solde": solde,
          }));

  static Future<Response> getCards(String holderId) async {
    return client
        .get(Utils.withBaseUrl("/getCards/$holderId", ApiRouteType.users));
  }

  static Future<Response> getAllUsers() async {
    return client.get(Utils.withBaseUrl("/", ApiRouteType.users));
  }

  static Future<Response> getById(int id) async {
    return client.get(Utils.withBaseUrl("/getbyId/$id", ApiRouteType.users));
  }

  static Future<Response> getByMail(String mail) async =>
      client.get(Utils.withBaseUrl("/getbyMail/$mail", ApiRouteType.users));
  static Future<Response> updateUser(Map<String, dynamic> payload) async =>
      client.put(Utils.withBaseUrl("/", ApiRouteType.users), body: payload);
  static Future<Response> deleteWithId(int id) async =>
      client.delete(Utils.withBaseUrl("/$id", ApiRouteType.users));
}
