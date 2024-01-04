import 'package:flutter/material.dart';
import '../../services/UserService.dart';
import 'dart:convert';

class SignUpUser extends StatefulWidget {
  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  bool isAccepted = false;
  String errormsg = "";
  String errormsgsms = "";
  String nom = '';
  String prenom = '';
  String username = '';
  String datenaissance = '';
  String tel = '';
  String email = '';
  String psw = '';
  String adresse = '';
  String codepostal = '';
  String CiviliteselectedValue = "Monsieur";
  String JobselectedValue = "Employé";
  String CountryselectedValue = "Tunisie";
  String CityeslectedValue = "Tunis";
  String SmsCode = "1";
  String UsersmsCode = "";
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

  List<DropdownMenuItem<String>> get CityItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Ariana"), value: "Ariana"),
      const DropdownMenuItem(child: Text("Beja"), value: "Beja"),
      const DropdownMenuItem(child: Text("Ben Arous"), value: "Ben Arous"),
      const DropdownMenuItem(child: Text("Bizerte"), value: "Bizerte"),
      const DropdownMenuItem(child: Text("Gabés"), value: "Gabés"),
      const DropdownMenuItem(child: Text("Gafsa"), value: "Gafsa"),
      const DropdownMenuItem(child: Text("Jendouba"), value: "Jendouba"),
      const DropdownMenuItem(child: Text("Kairouan"), value: "Kairouan"),
      const DropdownMenuItem(child: Text("Kasserine"), value: "Kasserine"),
      const DropdownMenuItem(child: Text("Kébili"), value: "Kébili"),
      const DropdownMenuItem(child: Text("Kéf"), value: "Kéf"),
      const DropdownMenuItem(child: Text("Mehdia"), value: "Mehdia"),
      const DropdownMenuItem(child: Text("Manouba"), value: "Manouba"),
      const DropdownMenuItem(child: Text("Médenine"), value: "Médenine"),
      const DropdownMenuItem(child: Text("Monastir"), value: "Monastir"),
      const DropdownMenuItem(child: Text("Nabeul"), value: "Nabeul"),
      const DropdownMenuItem(child: Text("Sfax"), value: "Sfax"),
      const DropdownMenuItem(child: Text("Sidi bouzid"), value: "Sidi bouzid"),
      const DropdownMenuItem(child: Text("Siliana"), value: "Siliana"),
      const DropdownMenuItem(child: Text("Sousse"), value: "Sousse"),
      const DropdownMenuItem(child: Text("Tataouine"), value: "Tataouine"),
      const DropdownMenuItem(child: Text("Tozeur"), value: "Tozeur"),
      const DropdownMenuItem(child: Text("Tunis"), value: "Tunis"),
      const DropdownMenuItem(child: Text("Zaghouane"), value: "Zaghouane"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get CountryItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Tunisie"), value: "Tunisie"),
    ];
    return menuItems;
  }

  Widget _dialogsms() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 200,
        width: 300,
        child: Column(
          children: [
            const Text(
              "code de confirmation:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                width: 250,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (text) {
                    UsersmsCode = text;
                  },
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  obscureText: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    hintText: "Confirmation code",
                    hintStyle: TextStyle(
                      color: const Color(0xFF1A1A1A).withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Mosk',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FlatButton(
                    onPressed: () async {
                      if (UsersmsCode == SmsCode) {
                        var rsp = await registerUser(
                            nom,
                            prenom,
                            username,
                            datenaissance,
                            tel,
                            email,
                            psw,
                            JobselectedValue,
                            CiviliteselectedValue,
                            adresse,
                            codepostal,
                            CityeslectedValue,
                            CountryselectedValue);
                        Navigator.of(context).pop();

                        if (rsp.statusCode == 200) {
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
                                      Navigator.of(context).pop();
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
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                content: const Text(
                                    "User added successfully now you can sign in"),
                              );
                            },
                          );
                        } else {
                          var convertedJson = json.decode(rsp.body);
                          setState(() {
                            errormsg = convertedJson["error"];
                          });
                        }
                      } else {
                        setState(() {
                          errormsgsms = "code invalide";
                        });

                        //print("error de message sms");
                      }

                      // Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.greenAccent,
                    shape: const StadiumBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  errormsgsms,
                  style: const TextStyle(
                    fontFamily: 'Arial Rounded MT',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 350,
        width: 300,
        child: Column(
          children: [
            const Text(
              "Champ d'application:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                width: 250,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Text(
                  "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        isAccepted = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Accepte",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.greenAccent,
                    shape: StadiumBorder(),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Refuse",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.yellowAccent,
                    shape: const StadiumBorder(),
                  ),
                ),
              ],
            )
          ],
        ),
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
          if (isAccepted == false) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _dialog();
                });
          }
          if (isAccepted == true) {
            var rspverif = await verifyUser(
                nom,
                prenom,
                username,
                datenaissance,
                tel,
                email,
                psw,
                JobselectedValue,
                CiviliteselectedValue,
                adresse,
                codepostal,
                CityeslectedValue,
                CountryselectedValue);
            var convertedVerifJson = json.decode(rspverif.body);
            if (rspverif.statusCode == 200) {
              var rsp = await sendSms(tel);

              var convertedJson = json.decode(rsp.body);

              if (rsp.statusCode == 200) {
                setState(() {
                  SmsCode = convertedJson["code"].toString();
                  //  print(SmsCode);
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _dialogsms();
                    });
              } else {
                // print("erruer service sms");
              }
            } else {
              setState(() {
                errormsg = convertedVerifJson["error"];
              });
            }
            //print(rsp);
          }
        },
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
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
                      prenom = text;
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
                      username = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
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
                    height: 10,
                  ),
                  TextField(
                    onChanged: (text) {
                      datenaissance = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Date de naissance",
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
                      tel = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "N téléphone",
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
                      psw = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Mot de passe",
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
                      value: JobselectedValue,
                      hint: const Text('Fonction'),
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF868686),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      onChanged: (String? newValue) {
                        setState(() {
                          JobselectedValue = newValue!;
                        });
                      },
                      items: JobItems),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                      value: CiviliteselectedValue,
                      hint: const Text('Civilite'),
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF868686),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      onChanged: (String? newValue) {
                        setState(() {
                          CiviliteselectedValue = newValue!;
                        });
                      },
                      items: CiviliteItems),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (text) {
                      adresse = text;
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Adresse",
                      hintStyle: TextStyle(
                        color: const Color(0xFF1A1A1A).withOpacity(0.3),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Mosk',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: TextField(
                          onChanged: (text) {
                            codepostal = text;
                          },
                          cursorColor: Colors.black,
                          cursorWidth: 2,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: "Code postale",
                            hintStyle: TextStyle(
                              color: const Color(0xFF1A1A1A).withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Mosk',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 90,
                        child: DropdownButton(
                            value: CityeslectedValue,
                            hint: const Text('Ville'),
                            isExpanded: true,
                            underline: Container(
                              height: 2,
                              color: const Color(0xFF868686),
                            ),
                            icon: const Icon(Icons.play_arrow_rounded),
                            onChanged: (String? newValue) {
                              setState(() {
                                CityeslectedValue = newValue!;
                              });
                            },
                            items: CityItems),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 90,
                        child: DropdownButton(
                            value: CountryselectedValue,
                            hint: const Text('Pays'),
                            isExpanded: true,
                            underline: Container(
                              height: 2,
                              color: const Color(0xFF868686),
                            ),
                            icon: const Icon(Icons.play_arrow_rounded),
                            onChanged: (String? newValue) {
                              setState(() {
                                CountryselectedValue = newValue!;
                              });
                            },
                            items: CountryItems),
                      ),
                    ],
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  _buildLoginButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 3,
                        width: 150,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: const Color(0xFF707070).withOpacity(0.3)),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                        width: 150,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: const Color(0xFF707070).withOpacity(0.3)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
