import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_cash_manager/providers/cart_provider.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/providers/connectivity_provider.dart';
import 'package:mobile_cash_manager/providers/utils_provider.dart';
import 'package:mobile_cash_manager/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:mobile_cash_manager/routes/routes.dart' as route;
import 'package:dcdg/dcdg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const GothamMobile());
}

class GothamMobile extends StatefulWidget {
  const GothamMobile({super.key});

  @override
  State<GothamMobile> createState() => _GothamMobileState();
}

class _GothamMobileState extends State<GothamMobile> {
  @override
  void initState() {
    setup();
    super.initState();
  }

  Future<void> setup() async {}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
          ChangeNotifierProvider(create: (context) => ClientProvider()),
          ChangeNotifierProvider(create: (context) => UtilsProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider())
        ],
        builder: (context, Widget? w) => MaterialApp(
            theme: themeData,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: route.controller,
            initialRoute: route.loadData));
  }
}
