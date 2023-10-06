import 'dart:developer';

import 'package:logger/logger.dart';
import 'package:mobile_cash_manager/shared/constants.dart';

enum ApiRouteType { users, articles }

class Utils {
  static Logger logger = Logger();

  static Uri withBaseUrl(String url, ApiRouteType type) {
    String u = "$baseUrl";
    switch (type) {
      case ApiRouteType.users:
        u += "/users";
        break;
      case ApiRouteType.articles:
        u += "/article";
        break;
    }
    u += url;
    return Uri.parse(u);
  }
}
