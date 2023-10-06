import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/cart.dart';
import 'package:mobile_cash_manager/componants/my_cards.dart';
import 'package:mobile_cash_manager/models/article.dart';
import 'package:mobile_cash_manager/providers/cart_provider.dart';
import 'package:mobile_cash_manager/providers/utils_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/utils/app_theme.dart';
import 'package:mobile_cash_manager/views/add_card.dart';
import 'package:mobile_cash_manager/views/home.dart';
import 'package:mobile_cash_manager/views/profile.dart';
import 'package:mobile_cash_manager/views/settings.dart';
import 'package:provider/provider.dart';

import 'barcode_scan.dart';

class MenuNav extends StatefulWidget {
  final int firstIndex;
  const MenuNav({super.key, required this.firstIndex});

  @override
  State<MenuNav> createState() => _MenuNavState();
}

class _MenuNavState extends State<MenuNav> {
  late int selectedIndex = widget.firstIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    List<Article> cartItem = provider.items;

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
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
      body: _buildMain(context),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: dark,
          type: BottomNavigationBarType.fixed,
          currentIndex: Provider.of<UtilsProvider>(context, listen: false)
                      .menuNavIndex >
                  4
              ? 1
              : Provider.of<UtilsProvider>(context, listen: true).menuNavIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      setBody(0);
                    })),
            BottomNavigationBarItem(
                label: "Scan",
                icon: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      setBody(1);
                    })),
            BottomNavigationBarItem(
                label: "Profile",
                icon: IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      setBody(2);
                    })),
            BottomNavigationBarItem(
                label: "Settings",
                icon: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    setBody(3);
                  },
                )),
          ]),
    );
  }

  void setBody(int index) {
    if (Provider.of<UtilsProvider>(context, listen: false).menuNavIndex !=
        index) {
      Provider.of<UtilsProvider>(context, listen: false).changeNavIndex(index);
    }
  }

  Widget _buildMain(BuildContext context) {
    switch (Provider.of<UtilsProvider>(context, listen: true).menuNavIndex) {
      case 0:
        return const Home();
      case 1:
        return const BarcodeScan();
      case 2:
        return const Profile();
      case 3:
        return const Settings();
      default:
        const Home();
    }
    return Container();
  }
}
