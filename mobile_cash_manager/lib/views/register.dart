import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile_cash_manager/api/user_api.dart';
import 'package:mobile_cash_manager/componants/custom_button.dart';
import 'package:mobile_cash_manager/componants/custom_text_field.dart';
import 'package:mobile_cash_manager/models/user.dart';
import 'package:mobile_cash_manager/providers/client_provider.dart';
import 'package:mobile_cash_manager/shared/colors.dart';
import 'package:mobile_cash_manager/utils/utils.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late final List<TextEditingController> controllers = [
    firstNameController,
    lastNameController,
    emailController,
    passwordController,
    confirmPasswordController
  ];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 84),
                    child: Text("Create your account",
                        style: TextStyle(fontSize: 32)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 12),
                    child: Column(
                      children: [
                        CustomTextField(
                            label: "First Name",
                            controller: firstNameController,
                            type: TextInputType.name),
                        const SizedBox(height: 20),
                        CustomTextField(
                            label: "Last Name",
                            controller: lastNameController,
                            type: TextInputType.name),
                        const SizedBox(height: 20),
                        CustomTextField(
                            label: "Email",
                            controller: emailController,
                            type: TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        CustomTextField(
                            label: "Password",
                            controller: passwordController,
                            type: TextInputType.text,
                            password: true),
                        const SizedBox(height: 20),
                        CustomTextField(
                            label: "Confirm Password",
                            controller: confirmPasswordController,
                            type: TextInputType.text,
                            password: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (loading) const CircularProgressIndicator.adaptive(),
                  CustomButton(
                      onPressed: loading ? null : () => register(),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          child: Text("Register")))
                ]),
          ),
        ));
  }

  Future<void> register() async {
    if (_validate()) {
      setState(() => loading = false);
      final Response res = await UserApi.createUser({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "solde": 0,
      });

      setState(() => loading = true);
      Utils.logger.i(res.body);
      Utils.logger.i(res.statusCode);

      if (res.statusCode == 201) {
        // const FlutterSecureStorage().write(
        //     key: "access_token", value: jsonDecode(res.body)["access_token"]);
        User user = User.fromJson(jsonDecode(res.body));

        // ignore: use_build_context_synchronously
        Provider.of<ClientProvider>(context, listen: false).changeUser(user);
        const FlutterSecureStorage().write(key: "user", value: user.toString());
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MenuNav(firstIndex: 0)),
            (route) => false);
      } else {
        _showSnackBar("Something went wrong during register");
      }
    }
  }

  bool _validate() {
    if (controllers.any((e) => e.text.isEmpty)) {
      _showSnackBar("Some fields are empty");
      return false;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      _showSnackBar("Email is invalid");
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar("Passwords don't match");
      return false;
    }
    return true;
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
