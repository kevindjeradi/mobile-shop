import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult? result;
  StreamSubscription? subscription;

  Future<void> setup() async {
    result = await Connectivity().checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {});
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }
}
