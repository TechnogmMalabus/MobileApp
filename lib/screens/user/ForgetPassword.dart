import 'package:flutter/material.dart';
import '../../services/UserService.dart';
import 'dart:convert';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = '';
  String errormsg = "";
  Widget _buildForgetButton() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xff00ccff),
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: const Text(
          'Reset password',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          var rsp = await forgetPassword(email);
          var convertedJson = json.decode(rsp.body);
          if (rsp.statusCode == 200) {
            print(convertedJson);
            setState(() {
              errormsg = "";
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Ok"),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  content: const Text("An email has been sent to this adress"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.greenAccent,
                      shape: const StadiumBorder(),
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              errormsg = convertedJson["error"];
            });
          }
        },
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      onChanged: (text) {
        email = text;
      },
      cursorColor: Colors.black,
      cursorWidth: 2,
      obscureText: false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        prefixIcon: const Icon(Icons.email, color: Colors.black),
        hintText: "Email",
        hintStyle: TextStyle(
          color: const Color(0xFF1A1A1A).withOpacity(0.3),
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Mosk',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ).copyWith(top: 60),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  alignment: Alignment.topRight,
                  width: 107,
                  height: 56,
                ),
                const Text(
                  'Reset your password',
                  style: TextStyle(
                    fontFamily: 'Arial Rounded MT',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF19184A),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildTextField(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  errormsg,
                  style: const TextStyle(
                    fontFamily: 'Arial Rounded MT',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildForgetButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
