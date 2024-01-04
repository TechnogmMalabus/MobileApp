import 'package:flutter/material.dart';
import '../../services/UserService.dart';
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class LoginUser extends StatefulWidget {
  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  bool? isChecked = false;
  String username = "";
  String psw = "";
  String errormsg = "";
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      // print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    //  print(
    //  prettyPrint(_accessToken!.toJson()),
    //  );
  }

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      // print(_userData);
      Navigator.pushNamed(context, '/home');
    } else {
      // print(result.status);
      //print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();

    setState(() {
      _accessToken = null;
      _userData = null;
    });
  }

/*  Widget _buildForgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'Mot de passe oubliée?',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: const Color(0xff18164B).withOpacity(0.6),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/forgetpassword');
        },
      ),
    );
  }
*/
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
          'Connection',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          var rsp = await loginUser(username, psw);
          SharedPreferences.setMockInitialValues({});
          final prefs = await SharedPreferences.getInstance();
          // print(rsp);
          var convertedJson = json.decode(rsp.body);
          if (rsp.statusCode == 200) {
            prefs.setString('userId', convertedJson['user']['_id'].toString());
            prefs.setString('token', convertedJson['token'].toString());

            setState(() {
              errormsg = "";
            });

            Navigator.pushNamed(context, "/home");
          } else {
            print(convertedJson["error"]);
            setState(() {
              errormsg = convertedJson["error"];
            });
          }
        },
      ),
    );
  }

  Widget _buildLogoButton({
    required String image,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }

/*  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       /* _buildLogoButton(
          image: 'assets/images/google_logo.png',
          onPressed: () {
            _logOut();
          },
        ),*/
        _buildLogoButton(
          image: 'assets/images/facebook_logo.png',
          onPressed: () {
            _login();
            // _logOut();
          },
        )


      ],
    );
  }*/



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
                      username = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      //filled: true,
                      //fillColor: const Color(0xFF5180ff),
                      prefixIcon: const Icon(Icons.supervised_user_circle,
                          color: Colors.black),
                      hintText: "Username",
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
                 /* _buildForgotPasswordButton(),
                  const SizedBox(
                    height: 20,
                  ),*/
                  _buildLoginButton(),
                  const SizedBox(
                    height: 30,
                  ),

               /*   _buildSocialButtons(),
                  const SizedBox(
                    height: 30,
                  ),*/

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
