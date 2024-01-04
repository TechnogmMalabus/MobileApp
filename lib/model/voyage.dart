class Voyage {
  late String id;
  late String nomLigne;
  late String dateVoyage;
  late String Nbrtickets;
  late String numBus;
  late String arretDepart;
  late String arretArrive;
  late String heurDepart;
  late String heurArrive;
  late String distance;
  late String prix;
  // String arrets;
  late String duree;
  late List arrets = [];

  Voyage(
      {required this.id,
      required this.nomLigne,
      required this.dateVoyage,
      required this.Nbrtickets,
      required this.numBus,
      required this.arretDepart,
      required this.arretArrive,
      required this.heurDepart,
      required this.heurArrive,
      required this.distance,
      required this.prix,
      required this.arrets,
      required this.duree});

  @override
  String toString() {
    return 'Voyage{id: $id, nomLigne: $nomLigne, dateVoyage: $dateVoyage, Nbrtickets: $Nbrtickets, numBus: $numBus, arretDepart: $arretDepart, arretArrive: $arretArrive, heurDepart: $heurDepart, heurArrive: $heurArrive, distance: $distance, prix: $prix, arrets: $arrets, duree: $duree}';
  }
}
