import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class DigitalClockX extends StatelessWidget {
  const DigitalClockX({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Container(
          clipBehavior: Clip.none,
          width: MediaQuery.of(context).size.width * .98,
          height: MediaQuery.of(context).size.height * .1,
          decoration: BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * (.35),
          top: MediaQuery.of(context).size.width * (-.22),
          child: CircleAvatar(
            radius: 150,
            backgroundColor: Colors.pink,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 7,
            bottom: 5,
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
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
