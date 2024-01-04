import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:malabus1/model/arret.dart';
import 'dart:async';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;
  DetailsResult? position;
  late CameraPosition _initialPosition;
  final _SearchFieldController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);

    if (result != null && result.predictions != null && mounted) {
      //print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  final Set<Marker> _markers = Set();
  List<LatLng> polylineCoordinates = [];

  void initState() {
    super.initState();
    String apiKey = 'AIzaSyCEev6xvgkM6VzLaOKKdElpQMERRO2dJXs';
    googlePlace = GooglePlace(apiKey);
    polylineCoordinates.clear();
    _markers.clear();
  }

  Text durreArret(int i, Arret arret, List<Arret> arrets) {
    if (i == 0) {
      return const Text(
        "Votre station",
        style: TextStyle(
            color: Color(0xff727373), fontSize: 9, fontWeight: FontWeight.w500),
      );
    } else if (i == arrets.length - 1) {
      return const Text(
        "Votre destination",
        style: TextStyle(
            color: Color(0xff727373), fontSize: 9, fontWeight: FontWeight.w500),
      );
    } else {
      return Text(
        arret.dureeArret,
        style: const TextStyle(
            color: Color(0xff727373), fontSize: 9, fontWeight: FontWeight.w500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<Arret>;

    for (var prop in args) {
      _markers.add(Marker(
          markerId: MarkerId(prop.nom),
          position: LatLng(
            double.parse(prop.latitude),
            double.parse(prop.longitude), //position of marker
          )));

      polylineCoordinates.add(
          LatLng(double.parse(prop.latitude), double.parse(prop.longitude)));
    }
    final LatLng _center = polylineCoordinates[0];
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: {
                Polyline(
                    polylineId: PolylineId('ppl'),
                    color: Colors.red,
                    width: 5,
                    points: polylineCoordinates)
              },
            ),
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.grey,
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _SearchFieldController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                hintText: "Trouver des stations",
                                suffixIcon: _SearchFieldController
                                        .text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            predictions = [];
                                            _SearchFieldController.clear();
                                          });
                                        },
                                        icon: const Icon(Icons.clear_outlined),
                                      )
                                    : null),
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false)
                                _debounce!.cancel();
                              _debounce =
                                  Timer(const Duration(milliseconds: 1000), () {
                                if (value.isNotEmpty) {
                                  //places api
                                  autoCompleteSearch(value);
                                } else {
                                  //clear out the results
                                  predictions = [];
                                  position = null;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                              ),
                            ),
                            title:
                                Text(predictions[index].description.toString()),
                            onTap: () async {
                              final placeId = predictions[index].placeId!;
                              final details =
                                  await googlePlace.details.get(placeId);
                              if (details != null &&
                                  details.result != null &&
                                  mounted) {
                                setState(() {
                                  position = details.result;
                                  _SearchFieldController.text =
                                      details.result!.name!;
                                  predictions = [];
                                });
                              }
                              if (position != null) {
                                setState(() {
                                  _markers.clear();
                                  polylineCoordinates.clear();
                                  _markers.add(Marker(
                                    markerId:
                                        MarkerId(position!.name!.toString()),
                                    position: LatLng(
                                        position!.geometry!.location!.lat!,
                                        position!.geometry!.location!.lng!),
                                  ));
                                  mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(
                                        position!.geometry!.location!.lat!,
                                        position!.geometry!.location!.lng!),
                                    zoom: 14.4746,
                                  )));
                                });
                              }
                            });
                      },
                      shrinkWrap: true,
                      itemCount: predictions.length,
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 0.5,
                snapSizes: const [0.2, 0.5],
                snap: true,
                builder: (BuildContext context, scrollSheetController) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(20))),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          controller: scrollSheetController,
                          itemCount: args.length,
                          itemBuilder: (BuildContext context, int index) {
                            final arret = args[index];
                            final lastOne = args[args.length - 1].nom;
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                      child: Divider(
                                        thickness: 5,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.favorite),
                                        Text(
                                            "Bus " + args[0].numBus.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(arret.nom),
                                            Icon(Icons.arrow_downward),
                                            Text(lastOne),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: const Divider(
                                        thickness: 3,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(Icons.fiber_manual_record,
                                          color: Color(0xFF00E1BF)),
                                      index == 0 || index == args.length - 1
                                          ? Text(
                                              arret.nom,
                                              style: const TextStyle(
                                                  color: Color(0xff00E1B5),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(arret.nom),
                                      durreArret(index, arret, args),
                                      Text(
                                        arret.heur,
                                        style: const TextStyle(
                                          color: Color(0xff00E1B5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        )),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
