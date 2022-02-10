import 'package:flutter/material.dart';

class CurrentWaqtDetails extends StatelessWidget {
  const CurrentWaqtDetails({
    Key? key,
    required this.context,
    required this.waqtName,
    required this.remainingTimeString,
  }) : super(key: key);

  final BuildContext context;
  final String waqtName;
  final String remainingTimeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .98,
      height: MediaQuery.of(context).size.height * .4,
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * (.35),
            top: MediaQuery.of(context).size.width * (-.42),
            child: const CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 150,
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * (.05),
            child: Column(
              children: [
                const Text(
                  "Time For",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  waqtName,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * (.1),
            top: MediaQuery.of(context).size.width * (.45),
            child: Column(
              children: [
                const Text(
                  "Time Left: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  remainingTimeString,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
