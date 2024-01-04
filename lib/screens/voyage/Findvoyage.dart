/*import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:malabus1/services/VoyageService.dart';
import 'package:malabus1/services/ArretService.dart';
import 'package:malabus1/model/voyage.dart';
import 'dart:convert';

class FindVoyage extends StatefulWidget {
  @override
  State<FindVoyage> createState() => _FindVoyageState();
}

class _FindVoyageState extends State<FindVoyage> {
  final CalendarWeekController _controller = CalendarWeekController();
  String Depart = "";
  String Arrive = "";
  String VoyageDate = "";
  List<Voyage> voyages = [];

  final List<String> _kOptions = <String>[];

  getArret() async {
    var rsp = await getAll();
    var convertedJson = json.decode(rsp.body);
    if (rsp.statusCode == 200) {
      for (var prop in convertedJson) {
        _kOptions.add(
          prop['nom_arret'].toString(),
        );
      }
      // print(_kOptions);
    }
  }

  @override
  void initState() {
    _kOptions.clear();
    super.initState();
    getArret();
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 48,
      width: 315,
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
          'Rechercher',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          String Month = "";
          String Day = "";
          switch (_controller.selectedDate.month) {
            case 1:
              {
                setState(() {
                  Month = "01";
                });
              }
              break;
            case 2:
              {
                setState(() {
                  Month = "02";
                });
              }
              break;
            case 3:
              {
                setState(() {
                  Month = "03";
                });
              }
              break;
            case 4:
              {
                setState(() {
                  Month = "04";
                });
              }
              break;
            case 5:
              {
                setState(() {
                  Month = "05";
                });
              }
              break;
            case 6:
              {
                setState(() {
                  Month = "06";
                });
              }
              break;
            case 7:
              {
                setState(() {
                  Month = "07";
                });
              }
              break;
            case 8:
              {
                setState(() {
                  Month = "08";
                });
              }
              break;
            case 9:
              {
                setState(() {
                  Month = "09";
                });
              }
              break;
            default:
              {
                setState(() {
                  Month = _controller.selectedDate.month.toString();
                });
              }
              break;
          }
          switch (_controller.selectedDate.day) {
            case 1:
              {
                setState(() {
                  Day = "01";
                });
              }
              break;
            case 2:
              {
                setState(() {
                  Day = "02";
                });
              }
              break;
            case 3:
              {
                setState(() {
                  Day = "03";
                });
              }
              break;
            case 4:
              {
                setState(() {
                  Day = "04";
                });
              }
              break;
            case 5:
              {
                setState(() {
                  Day = "05";
                });
              }
              break;
            case 6:
              {
                setState(() {
                  Day = "06";
                });
              }
              break;
            case 7:
              {
                setState(() {
                  Day = "07";
                });
              }
              break;
            case 8:
              {
                setState(() {
                  Day = "08";
                });
              }
              break;
            case 9:
              {
                setState(() {
                  Day = "09";
                });
              }
              break;
            default:
              {
                setState(() {
                  Day = _controller.selectedDate.day.toString();
                });
              }
              break;
          }
          VoyageDate = '${_controller.selectedDate.year}-${Month}-${Day}';
          var rsp = await findVoyage(Depart, Arrive, VoyageDate);

          var convertedJson = json.decode(rsp.body);

          if (rsp.statusCode == 200) {
            voyages.clear();
            for (var prop in convertedJson) {
              voyages.add(Voyage(
                  id: prop['id'].toString(),
                  nomLigne: prop['nomLigne'].toString(),
                  dateVoyage: prop['dateVoyage'].toString(),
                  Nbrtickets: prop['Nbrtickets'].toString(),
                  numBus: prop['numBus'].toString(),
                  arretDepart: prop['arretDepart'].toString(),
                  arretArrive: prop['arretArrive'].toString(),
                  heurDepart: prop['heurDepart'].toString(),
                  heurArrive: prop['heurArrive'].toString(),
                  distance: prop['distance'].toString(),
                  prix: prop['prix'].toString(),
                  arrets: prop['arrets'],
                  duree: prop['duree'].toString()));
              //print(prop['id']);
            }
            //print(voyages);
            Navigator.pushNamed(
              context,
              "/listvoyage",
              arguments: voyages,
            );
          } else {
            //print("errreur");
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getArret();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFFCFD0CF), //change your color here
        ),
        backgroundColor: Color(0xFFFFFFFF),
        title: const Center(
          child: Text(
            'Recherche de voyage',
            style: TextStyle(
                fontFamily: 'arial rounded mt',
                color: Color(0xff4C4C4C),
                fontSize: 15,
                fontWeight: FontWeight.bold),
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Do something.
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Sélectionner l\'itinéraire',
                style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    color: Color(0xFF95989A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 315,
              height: 140,
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
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _kOptions.where((String option) {
                        return option.startsWith(textEditingValue.text);

                        //.contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      Depart = selection;
                      debugPrint('You just selected $selection');
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        // onChanged: (text) {
                        //   Depart = text;
                        // },
                        decoration: const InputDecoration(
                          hintText: "De",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.circle,
                            color: Color(0xFF00E1BF),
                            size: 12,
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 270,
                        height: 0.95,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                        ),
                      ),
                      Icon(
                        Icons.sync_outlined,
                        color: Color(0xFF00E1BF),
                        size: 20,
                      ),
                    ],
                  ),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _kOptions.where((String option) {
                        return option.startsWith(textEditingValue.text);
                      });
                    },
                    onSelected: (String selection) {
                      Arrive = selection;
                      debugPrint('You just selected $selection');
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        // onChanged: (text) {
                        //   Depart = text;
                        //  },
                        decoration: const InputDecoration(
                          hintText: "Vers",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.circle,
                            color: Color(0xFF00E1BF),
                            size: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                'Sélectionner la date du voyage',
                style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    color: Color(0xFF95989A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1)
                ]),
                child: CalendarWeek(
                  controller: _controller,
                  height: 100,
                  showMonth: false,
                  pressedDateBackgroundColor: Color(0xFF00E2BF),
                  pressedDateStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  weekendsStyle: const TextStyle(
                      color: Color(0xFF7E7E7F),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  dateStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  dayOfWeekStyle: const TextStyle(
                      color: Color(0xFF7E7E7F),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  minDate: DateTime.now().add(
                    const Duration(days: -365),
                  ),
                  maxDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  onDatePressed: (DateTime datetime) {
                    // Do something
                    setState(() {});
                  },
                  onDateLongPressed: (DateTime datetime) {
                    // Do something
                  },
                  onWeekChanged: () {
                    // Do something
                  },
                  monthViewBuilder: (DateTime time) => Align(
                    alignment: FractionalOffset.center,
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          DateFormat.yMMMM().format(time),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )),
                  ),
                  decorations: [
                    DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                    ),
                    DecorationItem(
                      date: DateTime.now().add(Duration(days: 3)),
                    ),
                  ],
                )),
            // Expanded(
            //     child: Center(
            //      child: Text(
            //       '${_controller.selectedDate.day}/${_controller.selectedDate.month}/${_controller.selectedDate.year}',
            //       style: TextStyle(fontSize: 30),
            //     ),
            //    ),
            //  ),
            const SizedBox(
              height: 40,
            ),
            _buildLoginButton()
          ],
        ),
      ),
    );
  }
}*/
