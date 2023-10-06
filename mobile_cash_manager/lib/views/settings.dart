import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/my_cards.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/views/add_card.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(
              color: dark,
            ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCard(),
                ),
              );
            },
            icon: Icon(
              Icons.add_card_outlined,
              size: 45,
              color: dark,
            ),
            label: Text(
              'Ajouter une carte',
              style: TextStyle(color: dark),
            ),
          ),
          OutlinedButton.icon(
            style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(
              color: dark,
            ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCards(),
                ),
              );
            },
            icon: Icon(
              Icons.credit_card_outlined,
              size: 45,
              color: dark,
            ),
            label: Text(
              'Voir mes cartes',
              style: TextStyle(color: dark),
            ),
          ),
        ],
      ),
    );
  }
}
