import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
// import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/componants/custom_button.dart';
import 'package:mobile_cash_manager/componants/custom_text_field.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/shared/extensions.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';
import 'package:mobile_cash_manager/views/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120),
                    Text("Cash Manager",
                            style: TextStyle(color: dark, fontSize: 48))
                        .applyPadding(const EdgeInsets.only(bottom: 84)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        children: [
                          CustomTextField(
                              label: "Email",
                              controller: emailController,
                              type: TextInputType.emailAddress),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                              label: "Password",
                              controller: passwordController,
                              type: TextInputType.text,
                              password: true),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPressed: () => _login(),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text("Login"))),
                    const SizedBox(height: 40),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Don't have an account ?  ",
                            style: TextStyle(color: dark)),
                        TextSpan(
                            text: "Create your account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: dark),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              })
                      ]),
                    )
                    // IconButton(
                    //     icon: const Icon(Icons.dinner_dining),
                    //     onPressed: () => Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const MenuNav(firstIndex: 0)),
                    //         (route) => false))
                  ]),
            ),
          ),
        ));
  }

  Future<void> _login() async {
    String? userStored = await const FlutterSecureStorage().read(key: "user");
    void showSnack(String t) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      showSnack("Email and password are required.");
      return;
    }
    if (emailController.text.isEmpty) {
      showSnack("Email is required.");
      return;
    }
    if (passwordController.text.isEmpty) {
      showSnack("Password is required.");
      return;
    }
    UserApi.login(
            email: emailController.text, password: passwordController.text)
        .then((res) => {
              if (res.statusCode == 200)
                {
                  if (userStored == null)
                    {
                      Provider.of<ClientProvider>(context, listen: false)
                          .changeUser(User.fromJson(jsonDecode(res.body))),
                      const FlutterSecureStorage()
                          .write(key: "user", value: res.body.toString()),
                    }
                  else
                    {},
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuNav(firstIndex: 0)),
                      (route) => false)
                }
              else
                {
                  showSnack("Invalid credentials."),
                  showSnack(res.statusCode.toString())
                }
            });
  }
}
