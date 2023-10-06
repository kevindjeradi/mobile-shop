import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:mobile_cash_manager/api/interceptors/global_interceptor.dart';

final baseUrl = dotenv.env["GOTHAM_BASE_URI"];
final Client client =
    InterceptedClient.build(interceptors: [GlobalInterceptor()]);
