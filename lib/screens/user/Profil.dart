import 'package:flutter/material.dart';

import 'package:malabus1/model/user.dart';
import 'package:malabus1/services/UserService.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({Key? key, String? title}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";
  String dateNaissance = "";
  String numtel = "";
  String fonction = "";
  late User userP;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfil();
  }

  void getUserProfil() async {
    var rsp = await getProfil();

    if (rsp.statusCode == 200) {
      var convertedJson = json.decode(rsp.body);
      setState(() {
        userP = User(
            id: convertedJson['_id'],
            fname: convertedJson['fname'],
            lname: convertedJson['lname'],
            email: convertedJson['email'],
            username: convertedJson['username'],
            birthday: convertedJson['birthday'],
            phoneNum: convertedJson['phoneNum'],
            job: convertedJson['job'],
            civility: convertedJson["civility"],
            address: convertedJson["address"],
            postalCode: convertedJson['postalCode'],
            city: convertedJson['city'],
            country: convertedJson['country']);

        name = convertedJson['fname'].toString() +
            " " +
            convertedJson['lname'].toString();
        email = convertedJson['email'].toString();
        dateNaissance = convertedJson['birthday'].toString();
        numtel = convertedJson['phoneNum'].toString();
        fonction = convertedJson['job'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            'Profile',
            style: TextStyle(
                fontFamily: 'arial rounded mt',
                color: Color(0xff4C4C4C),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
       /* actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            color: const Color(0xFFCFD0CF),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],*/
      ),
      body: Container(
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
                      offset: const Offset(0, 1),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue Medium',
                      color: Color(0xff19184A),
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/updateprofil",
                          arguments: userP,
                        );
                      })
                ],
              ),
              Text(
                email,
                //  args.email,
                style: const TextStyle(
                    fontFamily: 'Helvetica Neue Regular',
                    color: Color(0xffB2B2B2),
                    fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Date de naissance:",
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      dateNaissance,
                      style: const TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
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
                    const Text(
                      "N de téléphone:",
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      numtel,
                      style: const TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
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
                    const Text(
                      "Fonction:",
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      fonction,
                      // args.job,
                      style: const TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              /*Container(
                color: Colors.white,
                width: double.infinity,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Historique de voyages:",
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue Medium',
                        color: Color(0xff4C4C4C),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(Icons.play_arrow_sharp)
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
