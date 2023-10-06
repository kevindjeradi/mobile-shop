import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  updateSolde(type, user, solde) async {
    final res = await UserApi.updateSolde(
        type: type, email: user.user!.email, solde: solde);
    User newUser = User.fromJson(jsonDecode(res.body));
    user.changeUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ClientProvider>(context, listen: true);

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      elevation: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(224, 224, 224, 1),
                            borderRadius: BorderRadius.circular(100)),
                        height: 200,
                        width: 200,
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/avatar.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                user.user!.firstName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: dark),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              user.user!.lastName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold, color: dark),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Mon solde",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Text("${user.user!.solde} €",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Créditer mon compte",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () async {
                            updateSolde("plus", user, 1.0);
                          },
                          child: const Text(
                            "1 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 5.0);
                          },
                          child: const Text(
                            "5 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 10.0);
                          },
                          child: const Text(
                            "10 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 15.0);
                          },
                          child: const Text(
                            "15 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 20.0);
                          },
                          child: const Text(
                            "20 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 25.0);
                          },
                          child: const Text(
                            "25 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 50.0);
                          },
                          child: const Text(
                            "50 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 100.0);
                          },
                          child: const Text(
                            "100 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 500.0);
                          },
                          child: const Text(
                            "500 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      color: dark,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            updateSolde("plus", user, 1000.0);
                          },
                          child: const Text(
                            "1000 €",
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
