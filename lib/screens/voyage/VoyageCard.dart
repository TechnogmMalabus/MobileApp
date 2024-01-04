import 'package:flutter/material.dart';
import 'package:malabus1/model/arret.dart';
import '../../model/voyage.dart';
import 'package:malabus1/services/ArretService.dart';
import 'dart:convert';

class VoyageCard extends StatefulWidget {
  late List<Voyage> ListVoyage;

  VoyageCard(
    this.ListVoyage,
  );

  @override
  State<VoyageCard> createState() => _VoyageCardState();
}

class _VoyageCardState extends State<VoyageCard> {
  bool _customTileExpanded = false;
  List<Arret> ListArret = [];
  late String heur;

  @override
  Widget build(BuildContext context) {
    return bodyContent(widget.ListVoyage);
  }

  ///////////////////////////
  bodyContent(List<Voyage> ListVoyage) {
    return ListView.builder(
        itemCount: ListVoyage.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // width: 343,
              // height: 112.5,
              child: Card(
                //color: Colors.red,
                child: ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                  trailing: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_rounded
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.platform,
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(3, 3, 40, 0),
                            child: Text(
                              ListVoyage[index].duree,
                              style: const TextStyle(
                                  color: Color(0xff00E1B5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '2 jour 8 heur 10 minutes',
                              style: TextStyle(
                                  color: Color(0xff00E1B5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 2, 0, 0),
                            child: GestureDetector(
                              child: const Icon(
                                Icons.location_on,
                                color: Color(0xff00E1B5),
                              ),
                              // onTap: () => print(ListVoyage[index].id),
                              onTap: () async {
                                ListArret.clear();

                                var rsp = await arretLatLong(
                                    ListVoyage[index].id,
                                    ListVoyage[index].arretDepart,
                                    ListVoyage[index].arretArrive);
                                // print("///////heur de depart//////");
                                //  print(ListVoyage[index].arrets[0]
                                //  ['heure_depart']);
                                //  print(ListVoyage[index].heurDepart);
                                var convertedJson = json.decode(rsp.body);
                                if (rsp.statusCode == 200) {
                                  int i = 0;
                                  for (var prop in convertedJson) {
                                    if (ListVoyage[index].arrets[i]
                                            ['heure_depart'] !=
                                        "") {
                                      setState(() {
                                        heur = ListVoyage[index].arrets[i]
                                            ['heure_depart'];
                                      });
                                    } else {
                                      setState(() {
                                        heur = ListVoyage[index].arrets[i]
                                            ['heure_arrive'];
                                      });
                                    }
                                    ListArret.add(Arret(
                                      prop['latitude'].toString(),
                                      prop['longitude'].toString(),
                                      prop['nom_arret'].toString(),
                                      prop['duree_arret'].toString(),
                                      heur,
                                      ListVoyage[index].numBus,
                                    ));
                                    i++;
                                  }

                                  //print(ListArret);
                                  Navigator.pushNamed(
                                    context,
                                    "/map",
                                    arguments: ListArret,
                                  );
                                } else {
                                  //print("pas de voyage");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ListVoyage[index].heurDepart,
                            style: const TextStyle(
                                fontFamily: 'arial rounded mt',
                                color: Color(0xff4C4C4C),
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Icon(
                            Icons.fiber_manual_record,
                            color: Color(0xFF00E1BF),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Flexible(
                              child: Text(
                            ListVoyage[index].arretDepart,
                            style: const TextStyle(
                                fontFamily: 'arial rounded mt',
                                color: Color(0xff4C4C4C),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          )),
                          const SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 98,
                          ),
                          Container(
                            color: Colors.red,
                            child: const SizedBox(
                              width: 1.5,
                              height: 12.03,
                            ),
                          )
                        ],
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ListVoyage[index].heurArrive,
                            style: const TextStyle(
                                fontFamily: 'arial rounded mt',
                                color: Color(0xff4C4C4C),
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Icon(
                            Icons.fiber_manual_record,
                            color: Color(0xFF00E1BF),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Flexible(
                              child: Text(
                            ListVoyage[index].arretArrive,
                            style: const TextStyle(
                                fontFamily: 'arial rounded mt',
                                color: Color(0xff4C4C4C),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text.rich(TextSpan(
                                style: const TextStyle(
                                    color:
                                        Colors.redAccent), //apply style to all
                                children: [
                                  const TextSpan(
                                      text: 'Ticket disponible: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                          color: Color(0xFF19184A))),
                                  TextSpan(
                                    text: ListVoyage[index].Nbrtickets,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFFB2B2B2),
                                        fontWeight: FontWeight.w400),
                                  )
                                ])),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/sntri.png',
                                width: 168.67,
                                height: 37.82,
                              ),
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Color(0xFF00E2BF),
                                ),
                                width: 85,
                                height: 25,
                                child: Center(
                                    child: Text(
                                  ListVoyage[index].prix,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ))),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: Color(0xFF00E1BF),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text.rich(TextSpan(
                                  style: const TextStyle(
                                      color: Colors
                                          .redAccent), //apply style to all
                                  children: [
                                    const TextSpan(
                                        text: 'Ligne : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color(0xFF333333))),
                                    TextSpan(
                                      text: ListVoyage[index].nomLigne,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF757575),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ])),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Réserver et payer'), // <-- Text
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
                  ],
                ),
              ),
            ),
          );
        });
  }
////////////////////////////

}
