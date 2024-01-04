import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../voyage/VoyageDetails.dart';
import '../voyage/VoyageDetails2.dart';
import '../voyage/ReservationPayment.dart';

class Details extends StatefulWidget {
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: [
                VoyageDetails(),
                const VoyageurCommande(),
                ReservationPayment()
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: JumpingDotEffect(
              activeDotColor: const Color(0xff00E1B5),
              dotColor: Colors.deepPurple.shade100,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
              //verticalOffset: 50,
              jumpScale: 3,
            ),
          ),
        ],
      ),
    );
  }
}
