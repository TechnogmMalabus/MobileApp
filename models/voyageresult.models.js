const Voyagee = function (
  id, nomLigne, dateVoyage, Nbrtickets, numBus,
  arretDepart, arretArrive, heurDepart, heurArrive, distance, prix, arrets, duree
){
  this.id = id;
  this.nomLigne = nomLigne;
  this.dateVoyage = dateVoyage;
  this.Nbrtickets = Nbrtickets;
  this.numBus = numBus;
  this.arretDepart = arretDepart;
  this.arretArrive = arretArrive;
  this.heurDepart = heurDepart;
  this.heurArrive =heurArrive;
  this.distance = distance;
  this.prix = prix;
  this.arrets = arrets;
  this.duree = duree;
  
}


module.exports.Voyagee = Voyagee;