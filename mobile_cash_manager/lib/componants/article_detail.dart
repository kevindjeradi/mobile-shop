import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/cart.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/providers/cart_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../views/menu_nav.dart';
import 'count_controller.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  int? countControllerValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    List<Article> cartItem = provider.items;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuNav(firstIndex: 0)),
                    (route) => false);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 24, 0),
                child: badges.Badge(
                  badgeContent: Text(
                    '${cartItem.length}',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: dark,
                        ),
                  ),
                  showBadge: true,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.yellow,
                  elevation: 4,
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  position: BadgePosition.topEnd(),
                  animationType: BadgeAnimationType.scale,
                  toAnimate: true,
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Cart(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            backgroundColor: dark,
            title: Image.asset(
              "assets/money.png",
              fit: BoxFit.contain,
              height: 60,
              width: 60,
            ),
            centerTitle: true),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Hero(
                      tag: widget.article.nom + Random(10000).toString(),
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.article.image,
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Text(
                      widget.article.nom,
                      style: AppTheme.of(context).title1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                    child: Text(
                      '${widget.article.prix} €',
                      textAlign: TextAlign.start,
                      style: AppTheme.of(context).subtitle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: Text(
                      widget.article.description,
                      style: AppTheme.of(context).bodyText2,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: dark,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x320F1113),
                      offset: Offset(0, -2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.yellow,
                            width: 2,
                          ),
                        ),
                        child: CountController(
                          decrementIconBuilder: (enabled) => Icon(
                            Icons.remove_rounded,
                            color: dark,
                            size: 16,
                          ),
                          incrementIconBuilder: (enabled) => Icon(
                            Icons.add_rounded,
                            color: dark,
                            size: 16,
                          ),
                          countBuilder: (count) => Text(
                            count.toString(),
                            style: AppTheme.of(context).subtitle1,
                          ),
                          count: countControllerValue ??= 1,
                          updateCount: (count) =>
                              setState(() => countControllerValue = count),
                          stepSize: 1,
                          minimum: 1,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            ),
                          ),
                          child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  Article a = widget.article;
                                  a.quantite = countControllerValue!.toInt();
                                  provider.addItem(a);
                                });
                              },
                              icon: Icon(Icons.add_shopping_cart_outlined,
                                  color: dark),
                              label: Text("Ajouter au panier",
                                  style: TextStyle(color: dark)),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.yellow,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
