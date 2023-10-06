import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/providers/cart_provider.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/utils/app_theme.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Article> cartItems;

  updateSolde(type, user, solde) async {
    final res = await UserApi.updateSolde(
        type: type, email: user.user!.email, solde: solde);
    User newUser = User.fromJson(jsonDecode(res.body));
    user.changeUser(newUser);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    final user = Provider.of<ClientProvider>(context, listen: true);
    final scaff = ScaffoldMessenger.of(context);

    cartItems = provider.items;

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: IconButton(
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
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        'Back',
                        style: AppTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Cart',
                    style: AppTheme.of(context).title1,
                  ),
                ),
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 8, 16, 0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: dark,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x320E151B),
                                    offset: Offset(0, 1),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Hero(
                                      tag: cartItems[index].nom +
                                          Random(10000).toString(),
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          cartItems[index].image,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 8),
                                            child: Text(
                                              cartItems[index].nom,
                                              style: AppTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.yellow,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            '${cartItems[index].prix} €',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 8, 0, 0),
                                            child: Text(
                                              'Quantité: ${cartItems[index].quantite}',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          provider.removeItem(cartItems[index]);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Récapitulatif',
                            style: AppTheme.of(context).bodyText2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'prix TTC',
                            style: AppTheme.of(context).subtitle2,
                          ),
                          Text(
                            "${provider.getTotal().toString()} €",
                            style: AppTheme.of(context).subtitle1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Total',
                                style: AppTheme.of(context).subtitle2,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.info_outlined,
                                  color: Color(0xFF57636C),
                                  size: 18,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          Text(
                            "${provider.getTotal().toString()} €",
                            style: AppTheme.of(context).title1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await updateSolde("minus", user, provider.getTotal());
                provider.clearCart();
                final snackBar = SnackBar(
                  content: const Text('Paiement effectué!'),
                  backgroundColor: (Colors.black12),
                  action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {},
                  ),
                );
                scaff.showSnackBar(snackBar);
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: dark,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x320E151B),
                      offset: Offset(0, -2),
                    )
                  ],
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(0),
                  //   bottomRight: Radius.circular(0),
                  //   topLeft: Radius.circular(16),
                  //   topRight: Radius.circular(16),
                  // ),
                ),
                alignment: const AlignmentDirectional(0, -0.35),
                child: Text(
                  "Paiement (${provider.getTotal().toString()} €)",
                  style: AppTheme.of(context).title2.override(
                        fontFamily: 'Poppins',
                        color: Colors.yellow,
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
