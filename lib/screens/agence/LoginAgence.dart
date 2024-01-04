import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/AgencyService.dart';

class LoginAgence extends StatefulWidget {
  @override
  State<LoginAgence> createState() => _LoginAgenceState();
}

class _LoginAgenceState extends State<LoginAgence> {
  bool? isChecked = false;
  String email = "";
  String psw = "";
  String errormsg = "";

  void initState() {
    super.initState();
  }


  Widget _buildLoginButton() {
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
          'Connextion',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          var rsp = await loginAgency(psw, email);

          var convertedJson = json.decode(rsp.body);
          if (rsp.statusCode == 200) {
            setState(() {
              errormsg = "";
            });
            Navigator.pushNamed(context, "/home");
          } else {
            setState(() {
              errormsg = convertedJson["error"];
            });
          }
        },
      ),
    );
  }

  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Vous n\'avez pas de compte ',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Color(0xff868686),
          ),
        ),
        InkWell(
          child: const Text(
            'Inscriver-vous',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff00ccff),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/signup");
          },
        ),
      ],
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    onChanged: (text) {
                      email = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      //filled: true,
                      //fillColor: const Color(0xFF5180ff),
                      prefixIcon:
                          const Icon(Icons.email_rounded, color: Colors.black),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: const Color(0xFF1A1A1A).withOpacity(0.3),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Mosk',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: (text) {
                      psw = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      //filled: true,
                      //fillColor: const Color(0xFF5180ff),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      hintText: "Mot de passe",
                      hintStyle: TextStyle(
                        color: const Color(0xFF1A1A1A).withOpacity(0.3),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Mosk',
                      ),
                    ),
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

                  _buildLoginButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSignUpQuestion(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
