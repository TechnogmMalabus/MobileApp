import 'package:flutter/material.dart';
import 'package:malabus1/model/user.dart';
/*import '../screens/voyage/Findvoyage.dart';*/
import '../screens/user/Profil.dart';
import '../screens/voyage/Favorite.dart';
import '../screens/voyage/Ticket.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final screens = [Profile()];
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: const Color(0xFF00E1BF),
          unselectedItemColor: const Color(0xFFD1D1D1),
          iconSize: 35,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp),
              label: 'home',
            ),
          ],
        ),
        body: screens[currentIndex]);
  }
}
