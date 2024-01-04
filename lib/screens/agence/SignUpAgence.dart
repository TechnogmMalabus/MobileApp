import 'package:flutter/material.dart';
import 'package:malabus1/services/AgencyService.dart';
import 'dart:convert';

class SignUpAgence extends StatefulWidget {
  @override
  State<SignUpAgence> createState() => _SignUpAgenceState();
}

class _SignUpAgenceState extends State<SignUpAgence> {
  String errormsg = "";
  String nom = '';
  String email = '';
  String matricule = '';
  String numcnss = '';
  bool _expanded = false;
  String LegalStatusselectedValue = "SARL";
  String BusnessSectorslectedValue =
      "Transport terrestre routier international";
  String QualityselectedValue = "commercial";

  List<DropdownMenuItem<String>> LegalStatusItems = [
    const DropdownMenuItem(child: Text("SARL"), value: "SARL"),
    const DropdownMenuItem(child: Text("SURL"), value: "SURL"),
    const DropdownMenuItem(child: Text("SAS"), value: "SAS"),
    const DropdownMenuItem(child: Text("SA"), value: "SA"),
  ];
  List<DropdownMenuItem<String>> QualiteItems = [
    const DropdownMenuItem(child: Text("CEO"), value: "CEO"),
    const DropdownMenuItem(child: Text("gérant"), value: "gérant"),
    const DropdownMenuItem(child: Text("commercial"), value: "commercial"),
    const DropdownMenuItem(child: Text("DAF"), value: "DAF"),
    const DropdownMenuItem(child: Text("PDG"), value: "PDG"),
    const DropdownMenuItem(child: Text("sousPDG"), value: "sousPDG"),
    const DropdownMenuItem(
        child: Text("Informaticien"), value: "Informaticien"),
    const DropdownMenuItem(child: Text("autre"), value: "autre"),
  ];

  List<DropdownMenuItem<String>> BusnessSectorItems = [
    const DropdownMenuItem(
        child: Text("TTRI"),
        value: "Transport terrestre routier international"),
    const DropdownMenuItem(
        child: Text("TTRM"),
        value: "Transport terrestre routier de marchandises"),
    const DropdownMenuItem(
        child: Text("TCP"), value: "Transport collectif de personnes"),
    const DropdownMenuItem(child: Text("TF"), value: "Transport ferroviaire"),
  ];

  Widget _buildForm() {
    return Column(
      children: [
        TextField(
          onChanged: (text) {
            nom = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: "Nom agence",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
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
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            matricule = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: "Matricule",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            numcnss = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: "Numero CNSS",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButton(
            value: LegalStatusselectedValue,
            hint: const Text('statut legal'),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: const Color(0xFF868686),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            onChanged: (String? newValue) {
              setState(() {
                LegalStatusselectedValue = newValue!;
              });
            },
            items: LegalStatusItems),
        DropdownButton(
            value: BusnessSectorslectedValue,
            hint: const Text('secteur'),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: const Color(0xFF868686),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            onChanged: (String? newValue) {
              setState(() {
                BusnessSectorslectedValue = newValue!;
              });
            },
            items: BusnessSectorItems),
        const SizedBox(
          height: 10,
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
      ],
    );
  }

  Widget _buildFormContac() {
    return Column(
      children: [
        TextField(
          onChanged: (text) {
            nom = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: "Nom",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
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
            hintText: "Prénom",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            matricule = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
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
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            numcnss = text;
          },
          cursorColor: Colors.black,
          cursorWidth: 2,
          obscureText: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: "Téléphone",
            hintStyle: TextStyle(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Mosk',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButton(
            value: QualityselectedValue,
            hint: const Text('Qualité'),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: const Color(0xFF868686),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            onChanged: (String? newValue) {
              setState(() {
                QualityselectedValue = newValue!;
              });
            },
            items: QualiteItems),
        const SizedBox(
          height: 10,
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
      ],
    );
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
          'Inscription',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          var rsp = await registerAgency(nom, matricule, numcnss,
              LegalStatusselectedValue, BusnessSectorslectedValue, email);
          if (rsp.statusCode == 200) {
            setState(() {
              errormsg = "";
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Success"),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  backgroundColor: Colors.white,
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.greenAccent,
                      shape: const StadiumBorder(),
                    ),
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  content: const Text("Agency added successfully "),
                );
              },
            );
          } else {
            var convertedJson = json.decode(rsp.body);
            setState(() {
              errormsg = convertedJson["error"];
            });
          }
        },
      ),
    );
  }

  Widget _buildTextField({
    required bool obscureText,
    String? hintText,
  }) {
    return Material(
      color: Colors.transparent,
      //  elevation: 2,
      child: TextField(
        onChanged: (text) {
          // value = text;
        },
        cursorColor: Colors.black,
        cursorWidth: 2,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          //filled: true,
          //fillColor: const Color(0xFF5180ff),

          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF1A1A1A).withOpacity(0.3),
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Mosk',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            // margin: EdgeInsets.all(30),
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            color: Colors.green,
            child: ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 1000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text(
                        'Informations Générale',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: _buildForm()),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {});
              },
            ),
          ),
          Container(
            //margin: EdgeInsets.all(30),
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: Colors.green,
            child: ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 1000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text(
                        'Personnes a contacter',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: _buildFormContac()),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {});
              },
            ),
          ),
          Container(
            //margin: EdgeInsets.all(30),
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: Colors.green,
            child: ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 1000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text(
                        'Adresse ',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: _buildForm()),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {});
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.all(30),
              color: Colors.green,
              child: _buildLoginButton())
        ]),
      ),
    );
  }
}
