import 'package:flutter/material.dart';
import 'package:malabus1/model/voyage.dart';
import 'package:malabus1/screens/voyage/VoyageCard.dart';

class VoyageList extends StatefulWidget {
  @override
  State<VoyageList> createState() => _VoyageListState();
}

class _VoyageListState extends State<VoyageList> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<Voyage>;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color(0xFFCFD0CF), //change your color here
          ),
          title: Center(
              child: Text(
            args[0].arretDepart + " - " + args[0].arretArrive,
            style: const TextStyle(
                fontFamily: 'arial rounded mt',
                color: Color(0xff4C4C4C),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              color: const Color(0xFFCFD0CF),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        body: VoyageCard(args));
  }
}
