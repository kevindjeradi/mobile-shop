import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/articles_list.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<ClientProvider>(context, listen: true).user;
    final mobileWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: mobileWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
                user != null
                    ? "Hello ${user.firstName} ${user.lastName} !"
                    : "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36)),
            const Padding(padding: EdgeInsets.all(20)),
            const ArticlesList()
          ]),
        ),
      ),
    );
  }
}
