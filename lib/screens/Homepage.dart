import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayertimes/api_services/prayerAPI.dart';
import 'package:prayertimes/models/weather.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final String _waqtNow;
  late var _prayerInfo;
  late String _month;
  late String _year;
  late Future<PrayerTimes> _prayer;
  var currentTime = DateTime.now();
  var remainingMinute;

  getMonthAndYear(now) {
    _month = DateFormat.M().format(now);
    _year = DateFormat.y().format(now);
  }

  @override
  void initState() {
    getMonthAndYear(currentTime);
    _prayer = APIService().getPrayerInfo(_month, _year);

    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
    super.initState();
  }

  remainingTimes(double first, double second) {
    var resultString;
    var temp = first.toString();
    var tempArray = temp.split(".");
    int temp11 = int.parse(tempArray[0]);
    int temp12 = int.parse(tempArray[1]);

    var temp2 = second.toString();
    var temp2Array = temp2.split(".");
    int temp21 = int.parse(temp2Array[0]);
    int temp22 = int.parse(temp2Array[1]);

    if (temp22 > temp12) {
      temp12 = temp12 + 60;
      temp11 = temp11 - 1;
    }
    var result11 = temp11 - temp21;
    var result12 = temp12 - temp22;

    return resultString = result11.abs().toString() + "." + result12.toString();
  }

  waqtTextBuilder(waqt) {
    String waqtName;
    String remainingTime;
    var _timeNowx = DateFormat.jm().format(currentTime);
    // var _timeNowx = "3:10 AM";
    var onlytime = _timeNowx.split(" ");
    var timenowVar = onlytime[0].split(":");
    double timenow = double.parse(timenowVar[0] + "." + timenowVar[1]);

    var Fajr = waqt.Fajr.toString().split(" ");
    var FajrTimeVar = Fajr[0].split(":");
    double FajrTimeDouble = double.parse(FajrTimeVar[0] + "." + FajrTimeVar[1]);
    if (FajrTimeDouble > 12) {
      FajrTimeDouble = FajrTimeDouble - 12;
    }

    var Sunrise = waqt.Sunrise.toString().split(" ");
    var SunriseTimeVar = Sunrise[0].split(":");
    double SunriseTimeDouble =
        double.parse(SunriseTimeVar[0] + "." + SunriseTimeVar[1]);
    if (SunriseTimeDouble > 12) {
      SunriseTimeDouble = SunriseTimeDouble - 12;
    }

    var Dhuhr = waqt.Dhuhr.toString().split(" ");
    var DhuhrTimeVar = Dhuhr[0].split(":");
    double DhuhrTimeDouble =
        double.parse(DhuhrTimeVar[0] + "." + DhuhrTimeVar[1]);
    if (DhuhrTimeDouble > 12) {
      DhuhrTimeDouble = DhuhrTimeDouble - 12;
    }

    var AsrTime = waqt.Asr.toString().split(" ");
    var AsrTimeVar = AsrTime[0].split(":");
    double AsrTimeDouble = double.parse(AsrTimeVar[0] + "." + AsrTimeVar[1]);
    if (AsrTimeDouble > 12) {
      AsrTimeDouble = AsrTimeDouble - 12;
    }

    var Maghrib = waqt.Maghrib.toString().split(" ");
    var MaghribTimeVar = Maghrib[0].split(":");
    double MaghribTimeDouble =
        double.parse(MaghribTimeVar[0] + "." + MaghribTimeVar[1]);
    if (MaghribTimeDouble > 12) {
      MaghribTimeDouble = MaghribTimeDouble - 12;
    }

    var Sunset = waqt.Sunset.toString().split(" ");
    var SunsetTimeVar = Sunset[0].split(":");
    double SunsetTimeDouble =
        double.parse(SunsetTimeVar[0] + "." + SunsetTimeVar[1]);
    if (SunsetTimeDouble > 12) {
      SunsetTimeDouble = SunsetTimeDouble - 12;
    }

    var IshaTime = waqt.Isha.toString().split(" ");
    var IshaTimeVar = IshaTime[0].split(":");
    double IshaTimeDouble = double.parse(IshaTimeVar[0] + "." + IshaTimeVar[1]);
    if (IshaTimeDouble > 12) {
      IshaTimeDouble = IshaTimeDouble - 12;
    }

    var MidnightTime = waqt.Midnight.toString().split(" ");
    var MidnightTimeVar = MidnightTime[0].split(":");

    double MidnightTimeDouble = 12.00;

    var ImsakTime = waqt.Imsak.toString().split(" ");
    var ImsakTimeVar = ImsakTime[0].split(":");
    double ImsakTimeDouble =
        double.parse(ImsakTimeVar[0] + "." + ImsakTimeVar[1]);
    if (ImsakTimeDouble > 12) {
      ImsakTimeDouble = ImsakTimeDouble - 12;
    }

    if (timenow > FajrTimeDouble && timenow < SunriseTimeDouble) {
      waqtName = "Fajr";
      remainingTime = remainingTimes(SunriseTimeDouble, timenow);
    } else if (timenow > DhuhrTimeDouble && timenow < AsrTimeDouble) {
      waqtName = "Dhuhr";
      remainingTime = remainingTimes(AsrTimeDouble, timenow);
    } else if (timenow > AsrTimeDouble && timenow < MaghribTimeDouble) {
      waqtName = "Asr";
      remainingTime = remainingTimes(MaghribTimeDouble, timenow);
    } else if (timenow > SunsetTimeDouble &&
        timenow < (SunsetTimeDouble + 0.30)) {
      waqtName = "Maghrib";
      remainingTime = remainingTimes(SunsetTimeDouble + 0.30, timenow);
    } else if (timenow > IshaTimeDouble && timenow < MidnightTimeDouble) {
      waqtName = "Isha";
      remainingTime = remainingTimes(MidnightTimeDouble, timenow);
    } else {
      waqtName = "Tahajjot";
      var time = (timenow - 12).toStringAsFixed(2);

      remainingTime = remainingTimes(FajrTimeDouble, double.parse(time));
    }
    var remainingTimeStringArray = remainingTime.split(".");
    String remainingTimeString = remainingTimeStringArray[0] +
        "H" +
        " " +
        remainingTimeStringArray[1] +
        "M";

    return Column(
      children: [
        Stack(
          // fit: StackFit.loose,
          clipBehavior: Clip.hardEdge,

          children: [
            // const Text(
            //   "Time For ",
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.white,
            //   ),
            // ),

            const Positioned(
              top: 40,
              left: 65,
              child: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 100,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .35,
              child: const Image(
                image: AssetImage('assets/mosque.png'),
              ),
            ),

            Positioned(
              top: 65,
              left: 115,
              child: Text(
                waqtName,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Time Left For : " + waqtName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          remainingTimeString,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  buildCard(time, text) {
    var onlyTime = time.split(" ");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .35,
          height: MediaQuery.of(context).size.height * .20,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Expanded(
            child: Card(
              color: Colors.pinkAccent,
              margin: const EdgeInsets.only(left: 20),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    onlyTime[0],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
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
            child: buildCard(waqt.Fajr.toString(), "Fajr"),
          ),
          // buildCard(waqt.Fajr.toString(), "Fajr"),
          buildCard(waqt.Dhuhr.toString(), "Dhuhr"),
          buildCard(waqt.Asr.toString(), "Asr"),
          buildCard(waqt.Maghrib.toString(), "Maghrib"),
          buildCard(waqt.Isha.toString(), "Isha"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DigitalClock(
                is24HourTimeFormat: false,
                digitAnimationStyle: Curves.bounceInOut,
                areaDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
                amPmDigitTextStyle: const TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .98,
              height: MediaQuery.of(context).size.height * .45,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .98,
                      // height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder<PrayerTimes>(
                            future: _prayer,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int index = int.parse(
                                        DateFormat.d().format(currentTime)) -
                                    1;
                                var prayertimes = snapshot.data!.data[index];

                                return waqtTextBuilder(prayertimes.timings);
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<PrayerTimes>(
              future: _prayer,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int index = int.parse(DateFormat.d().format(currentTime)) - 1;
                  var prayertimes = snapshot.data!.data[index];

                  return buildNamazTimes(prayertimes);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_view_month,
              ),
            )
          ],
        ),
      ),
    );
  }
}
