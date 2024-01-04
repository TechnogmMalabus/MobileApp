import 'package:flutter/material.dart';

class VoyageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              "Réservation",
              style: TextStyle(color: Color(0xFF4C4C4C)),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              color: Color(0xFFCFD0CF),
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
              height: 50,
            ),
            const Center(
                child: Text(
              "Détails de voyage",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19184A)),
            )),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 315,
              height: 325.85,
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Color(0xFF00E1BF),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tunis sud",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const Text("12:30")
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Color(0xFF00E1BF),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Gabes",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Text("18:20")
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Color(0xFF00E1BF),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Distance",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Text("475 Km")
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    TextField(
                      onChanged: (text) {},
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //filled: true,
                        //fillColor: const Color(0xFF5180ff),
                        prefixIcon: const Icon(
                          Icons.fiber_manual_record,
                          size: 12,
                          color: Color(0xFF00E1BF),
                        ),
                        hintText: "Nombre de places",
                        hintStyle: TextStyle(
                          color: const Color(0xFF1A1A1A).withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Mosk',
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Color(0xFF00E1BF),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Prix",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Text("25.700 TND"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 10,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
