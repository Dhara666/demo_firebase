import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProcessIndicator extends StatefulWidget {
  const CircularProcessIndicator({Key? key}) : super(key: key);

  @override
  State<CircularProcessIndicator> createState() => _CircularProcessIndicatorState();
}

class _CircularProcessIndicatorState extends State<CircularProcessIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: commonDurationIndicator(
                  0.4,
                  80,
                  35.0),
            ),
            ClipOval(
              child: Container(
                width: 110 - 30,
                height: 110 - 30,
                color: const Color.fromRGBO(
                    110, 136, 237, 0.9),
                // color: const Color.fromRGBO(
                //     50, 50, 115, 0.5),
                padding: const EdgeInsets.all(1.5),
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: const <Widget>[
                          Text("REMAINING",
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight:
                                FontWeight.w500,
                                color: Color(
                                    0x00ff868A8A)),
                          ),
                          Text(
                            "0.4",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w700,
                                color:
                                Colors.black),
                          ),
                          Text("OUT OF 1.GB",
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight:
                                FontWeight.w500,
                                color: Color(
                                    0xff868a8a)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonDurationIndicator(double m, double r, double w) {
    return CircularPercentIndicator(
      radius: r,
      lineWidth: w,
      percent: m,
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 1000,
      backgroundColor: const Color(0xff9eb0b7),
      circularStrokeCap: CircularStrokeCap.butt,
      progressColor: m.toString() == "NaN" ? const Color(0xff9eb0b7) :const Color(0xff97f991),
    );
  }
}
