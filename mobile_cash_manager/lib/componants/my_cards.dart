import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/models/cards.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/utils/app_theme.dart';
import 'package:mobile_cash_manager/views/add_card.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';
import 'package:provider/provider.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key? key}) : super(key: key);

  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCvvFocused = false;
  late List<Cards> cards;

  Future<List<Cards>> getCards() async {
    final resp = await UserApi.getCards(
        Provider.of<ClientProvider>(context, listen: true).user!.email);
    final list = jsonDecode(resp.body);

    try {
      cards = list.map<Cards>((e) => Cards.fromJson(e)).toList();
    } catch (e, s) {
      print("Error ---------------> " + e.toString());
      print("Stacktrace ---------------> " + s.toString());
    }

    print(cards);
    return cards;
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppTheme.of(context).primaryText,
                      size: 30,
                    ),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MenuNav(firstIndex: 0)),
                          (route) => false);
                    },
                  ),
                  Text(
                    'Mes cartes enregistrées',
                    style: AppTheme.of(context).title1,
                  ),
                ],
              ),
            ],
          ),
          elevation: 0,
        ),
      ),
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: getCards(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final cardsList = snapshot.data!;

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cardsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CreditCardWidget(
                                      bankName: "Bank",
                                      isHolderNameVisible: true,
                                      obscureCardCvv: true,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      cardNumber: cardsList[index].cardNumber,
                                      expiryDate: cardsList[index].expiryDate,
                                      cardHolderName:
                                          cardsList[index].cardHolder,
                                      cvvCode: cardsList[index].cvvCode,
                                      showBackView: isCvvFocused,
                                      onCreditCardWidgetChange:
                                          (CreditCardBrand) {},
                                    ),
                                  ],
                                );
                              }),
                        );
                      }
                      return const Text("dada");
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
