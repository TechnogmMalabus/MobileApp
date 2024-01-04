import 'package:flutter/material.dart';
import 'user/LoginUser.dart';
import 'agence/LoginAgence.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              // construct the profile details widget here
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/logo.png',
                alignment: Alignment.topRight,
                width: 107,
                height: 56,
              ),
              const SizedBox(
                height: 30,
                child: Center(
                  child: Text(
                    'Connection',
                    style: TextStyle(
                      fontFamily: 'Arial Rounded MT',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF19184A),
                    ),
                  ),
                ),
              ),
              const Text(
                'Connecter vous pour continuer',
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF868686),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              // the tab bar with two items
              SizedBox(
                height: 50,
                child: SizedBox(
                  width: 350,
                  child: AppBar(
                    backgroundColor: const Color(0xFFDCDCDC),
                    bottom: TabBar(
                      unselectedLabelColor: const Color(0xFFB6B7B8),
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(5), // Creates border
                          color: const Color(0xff00ccff)),
                      tabs: const [
                        Tab(
                          text: "Utilisateur",
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget

                    LoginUser(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
