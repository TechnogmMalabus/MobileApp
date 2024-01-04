import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malabus1/model/user.dart';
import 'package:malabus1/services/UserService.dart';
import 'dart:convert';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, String? title}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _birthdaycontroller = TextEditingController();
  final TextEditingController _numtelcontroller = TextEditingController();
  final TextEditingController _jobcontroller = TextEditingController();
  final TextEditingController _civilitecontroller = TextEditingController();
  final TextEditingController _adressecontroller = TextEditingController();
  String CiviliteselectedValue = "";
  String JobselectedValue = "";
  String errormsg = "";

  List<DropdownMenuItem<String>> get CiviliteItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Mlle"), value: "Mlle"),
      const DropdownMenuItem(child: Text("Madame"), value: "Madame"),
      const DropdownMenuItem(child: Text("Monsieur"), value: "Monsieur"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get JobItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("étudinat"), value: "étudinat"),
      const DropdownMenuItem(child: Text("Employé"), value: "Employé"),
      const DropdownMenuItem(child: Text("Chômeur"), value: "Chômeur"),
      const DropdownMenuItem(child: Text("Retraité"), value: "Retraité"),
    ];
    return menuItems;
  }

  String name = "";
  String email = "";
  String dateNaissance = "";
  String numtel = "";
  String fonction = "";
  @override
  void initState() {
    super.initState();
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 54,
      width: 150,
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
          'Update',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          String nom = _fnamecontroller.text.toString();
          String prenom = _lnamecontroller.text.toString();
          String mail = _mailcontroller.text.toString();
          // String datenaiss = _birthdaycontroller.text.toString();
          String numtel = _numtelcontroller.text.toString();
          String fonction = JobselectedValue.toString();
          String civilite = CiviliteselectedValue.toString();
          String adresse = _adressecontroller.text.toString();
          var rsp = await updateProfil(nom, prenom, "11/14/1995", numtel, mail,
              fonction, civilite, adresse);
          var convertedJson = json.decode(rsp.body);
          if (rsp.statusCode == 200) {
            Navigator.pushNamed(context, "/profil");
          } else {
            // print(convertedJson["error"]);
            setState(() {
              errormsg = convertedJson["error"];
            });
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initiatevalue();
  }

  void initiatevalue() {
    final args = ModalRoute.of(context)!.settings.arguments as User;
    _fnamecontroller.text = args.fname.toString();
    _lnamecontroller.text = args.lname.toString();
    _mailcontroller.text = args.email.toString();
    _birthdaycontroller.text = args.birthday.toString();
    _numtelcontroller.text = args.phoneNum.toString();
    // _jobcontroller.text = args.job.toString();
    // _civilitecontroller.text = args.civility.toString();
    _adressecontroller.text = args.address.toString();
    CiviliteselectedValue = args.civility.toString();
    JobselectedValue = args.job.toString();
  }

  @override
  Widget build(BuildContext context) {
    //initiatevalue();

    // final args = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFFCFD0CF), //change your color here
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Center(
          child: Text(
            'Modification de profil ',
            style: TextStyle(
                fontFamily: 'arial rounded mt',
                color: Color(0xff4C4C4C),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            color: const Color(0xFFCFD0CF),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF9F9F9),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Nom:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _fnamecontroller,
                          decoration: const InputDecoration(
                            hintText: "Nom",
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Prénom:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _lnamecontroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Prénom",
                          ),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Adresse Mail:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _mailcontroller,
                          decoration: const InputDecoration(
                            hintText: "Adresse Mail",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Date de naissance:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _birthdaycontroller,
                          decoration: const InputDecoration(
                            hintText: "Date de naissance",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "N de téléphone:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _numtelcontroller,
                          decoration: const InputDecoration(
                            hintText: "N de téléphone",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Fonction:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: DropdownButton(
                            value: JobselectedValue,
                            hint: const Text('Fonction'),
                            isExpanded: true,
                            style: const TextStyle(
                              fontFamily: 'Helvetica Neue Regular',
                              color: Color(0xff4C4C4C),
                              fontSize: 14,
                            ),
                            icon: const Icon(Icons.play_arrow_rounded),
                            onChanged: (String? newValue) {
                              setState(() {
                                JobselectedValue = newValue!;
                              });
                            },
                            items: JobItems),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Civilite:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: DropdownButton(
                            value: CiviliteselectedValue,
                            hint: const Text('Civilite'),
                            style: const TextStyle(
                              fontFamily: 'Helvetica Neue Regular',
                              color: Color(0xff4C4C4C),
                              fontSize: 14,
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.play_arrow_rounded),
                            onChanged: (String? newValue) {
                              setState(() {
                                CiviliteselectedValue = newValue!;
                              });
                            },
                            items: CiviliteItems),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Adresse:",
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue Medium',
                          color: Color(0xff4C4C4C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _adressecontroller,
                          decoration: const InputDecoration(
                            hintText: "Adresse",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue Regular',
                            color: Color(0xff4C4C4C),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
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
                const SizedBox(
                  height: 15,
                ),
                _buildLoginButton(),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
