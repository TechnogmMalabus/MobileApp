import 'package:flutter/material.dart';

class VoyageurCommande extends StatefulWidget {
  const VoyageurCommande({Key? key}) : super(key: key);

  @override
  State<VoyageurCommande> createState() => _VoyageurCommandeState();
}

class _VoyageurCommandeState extends State<VoyageurCommande> {
  bool value = true;
  Widget buildSwitch() => Transform.scale(
        scale: 0.7,
        child: Switch.adaptive(
          activeColor: Color(0xFF00E1BF),
          splashRadius: 50,
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              "Voyageur",
              style: TextStyle(color: Color(0xFF4C4C4C)),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              color: const Color(0xFFCFD0CF),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFCFD0CF),
              ),
              onPressed: () {
                // Do something.
              })),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              "Qui passe la commande ?",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19184A)),
            )),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 315,
              height: 112.33,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 7, // soften the shadow
                    spreadRadius: 5, //extend the shadow
                    offset: const Offset(
                      1.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),

                        hintText: "Foulenbenfoulen@gmail.com",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),

                        hintText: "216 123 456 7",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              "Qui voyage ?",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19184A)),
            )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "C’est la même personne qui passe la commande.",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4C4C4C)),
                  ),
                  buildSwitch(),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 315,
              height: 200.56,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 7, // soften the shadow
                    spreadRadius: 5, //extend the shadow
                    offset: const Offset(
                      1.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),

                        hintText: "Nom",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),

                        hintText: "Prenom",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),

                        hintText: "Date de naissance",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    // <-- Icon
                                    Icons.arrow_left_rounded,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Précedent'), // <-- Text
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Suivant'), // <-- Text
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    // <-- Icon
                                    Icons.play_arrow_rounded,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
