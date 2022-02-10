import 'package:flutter/material.dart';
import 'package:prayertimes/models/weather.dart';

class WaqtCards extends StatelessWidget {
  late Data prayertimes;
  late BuildContext context;

  // const WaqtCards({ required Data prayertimes, required BuildContext context, required this.prayertimes, this.context});

  buildCard(time, text, context) {
    var onlyTime = time.split(" ");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .35,
              height: MediaQuery.of(context).size.height * .20,
              child: Expanded(
                child: Card(
                  color: Colors.pinkAccent,
                  margin: const EdgeInsets.only(left: 20),
                  elevation: 10,
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              onlyTime[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/mosque.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildNamazTimes(prayerInfo) {
    var waqt = prayerInfo.timings;
    return Flexible(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: buildCard(waqt.Fajr.toString(), "Fajr", context),
          ),
          // buildCard(waqt.Fajr.toString(), "Fajr"),
          buildCard(waqt.Dhuhr.toString(), "Dhuhr", context),
          buildCard(waqt.Asr.toString(), "Asr", context),
          buildCard(waqt.Maghrib.toString(), "Maghrib", context),
          buildCard(waqt.Isha.toString(), "Isha", context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
