import 'package:flutter/material.dart';

class ReservationPayment extends StatefulWidget {
  @override
  State<ReservationPayment> createState() => _ReservationPaymentState();
}

class _ReservationPaymentState extends State<ReservationPayment> {
  bool? _masterCard = false;
  bool? _VisaCard = false;
  bool? _eDinar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              "Paiement",
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
              height: 20,
            ),
            const Center(
                child: Text(
              "Details de paiement",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19184A)),
            )),
            const SizedBox(
              height: 5,
            ),
            const Center(
                child: Text(
              "Cette transaction est sécurisée par chiffrement de bout en bout.",
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF727373)),
            )),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: 315,
              height: 359.1,
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
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text("Selectionnez votre carte"),
                  ),
                  CheckboxListTile(
                      value: _masterCard,
                      title: const Text("Master card"),
                      secondary: Image.asset(
                        "assets/images/mastercard.png",
                        width: 28,
                        height: 22,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _masterCard = value;
                          _eDinar = false;
                          _VisaCard = false;
                        });
                      }),
                  CheckboxListTile(
                      value: _VisaCard,
                      title: const Text("Visa card"),
                      secondary: Image.asset(
                        "assets/images/mastercard.png",
                        width: 28,
                        height: 22,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _VisaCard = value;
                          _eDinar = false;
                          _masterCard = false;
                        });
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
