import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/api/article_api.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/componants/article_detail.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({super.key});

  @override
  State<BarcodeScan> createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: dark,
          title: const Center(child: Text('Scannez un produit')),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                final barcodeArticle = await getArticleFromCode(code);
                print("2");
                print(barcodeArticle);
                if (!mounted) return;
                print(3);
                print(barcodeArticle);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetail(
                      article: barcodeArticle,
                    ),
                  ),
                  (route) => false,
                );

                debugPrint('Barcode found! $code');
              }
            }));
  }

  Future<Article> getArticleFromCode(String code) async {
    late Article art;
    final resp = await ArticleApi.getArticleByBarcode(code);
    final article = jsonDecode(resp.body);
    try {
      art = Article.fromJson(article[0]);
    } catch (e, s) {
      print("Error ---------------> " + e.toString());
      print("Stacktrace ---------------> " + s.toString());
    }
    return art;
  }
}
