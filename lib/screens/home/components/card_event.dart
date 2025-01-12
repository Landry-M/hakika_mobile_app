import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

cardEvent(
  BuildContext context,
  var customColor,
  String eventTitle,
  String eventType,
  int eventNbInviter,
  String eventDate,
  String salle,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Container(
      height: 270,
      width: MediaQuery.of(context).size.width / 1.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17), topRight: Radius.circular(17)),
            color: customColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 23,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_alarm,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('dd-MM-yy').format(
                              DateTime.parse(eventDate),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        eventTitle,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
              color: Color.fromARGB(255, 248, 245, 245),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 22,
                          child: Image.asset('lib/assets/img/group.png'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          eventNbInviter.toString(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        height: 05,
                        width: MediaQuery.of(context).size.width / 2,
                        child: LinearProgressBar(
                          maxSteps: 6,
                          progressType: LinearProgressBar
                              .progressTypeLinear, // Use Linear progress
                          currentStep: 0,
                          progressColor: customColor,
                          backgroundColor: Colors.white,
                          borderRadius: BorderRadius.circular(10), //  NEW
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eventType),
                      // const Spacer(),
                      Text(salle),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ),
  );
}
