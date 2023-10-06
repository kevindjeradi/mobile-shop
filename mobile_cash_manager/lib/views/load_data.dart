import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/utils/utils.dart';
import 'package:mobile_cash_manager/views/login.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';
import 'package:provider/provider.dart';

import '../providers/client_provider.dart';

class LoadData extends StatefulWidget {
  const LoadData({Key? key}) : super(key: key);

  @override
  State<LoadData> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadData();
    });
    super.initState();
  }

  void loadData() {
    const FlutterSecureStorage().read(key: "user").then((user) {
      if (user != null) {
        Provider.of<ClientProvider>(context, listen: false)
            .setUser(User.parse(user));
        Utils.logger.i("Successfully set user from storage to provider");

        if (Provider.of<ClientProvider>(context, listen: false).user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MenuNav(firstIndex: 0)),
              (route) => false);
        } else {}
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
        Utils.logger.i("No user in storage");
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
              child: Container(
        width: mobileWidth,
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Image.asset(
                  "assets/money.png",
                  fit: BoxFit.contain,
                  width: 170,
                )),
            const SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                )),
          ],
        ),
      ))),
    );
  }
}
