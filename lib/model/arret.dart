class Arret {
  late String latitude;
  late String longitude;
  late String nom;
  late String dureeArret;
  late String heur;
  late String numBus;

  Arret(this.latitude, this.longitude, this.nom, this.dureeArret, this.heur,
      this.numBus);

  @override
  String toString() {
    return 'Arret{latitude: $latitude, longitude: $longitude, nom: $nom, dureeArret: $dureeArret, heur: $heur, numBus: $numBus}';
  }
}
