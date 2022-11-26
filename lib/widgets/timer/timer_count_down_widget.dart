// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:omega_clock/modules/vibration_check.dart';

import 'package:neon_circular_timer/neon_circular_timer.dart';

class TimerCountDown extends StatefulWidget {
  int _duration;
  TimerCountDown(this._duration, {Key? key}) : super(key: key);

  @override
  State<TimerCountDown> createState() => _TimerCountDownState();
}

class _TimerCountDownState extends State<TimerCountDown> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  final CountDownController controller = new CountDownController();

  bool _start = false;

  void startTimer() {
    Future.delayed(const Duration(milliseconds: 1), () {
      controller.start();
      controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          NeonCircularTimer(
              onComplete: () async {
                Vibro().vibration();
              },
              textFormat: TextFormat.MM_SS,
              textStyle: TextStyle(
                fontSize: 45,
                fontFamily: "PTMono",
              ),
              autoStart: false,
              isReverse: true,
              isReverseAnimation: true,
              width: 300,
              controller: controller,
              duration: widget._duration,
              strokeWidth: 10,
              isTimerTextShown: true,
              neumorphicEffect: true,
              outerStrokeColor: Colors.grey.shade100,
              innerFillGradient: LinearGradient(colors: [
                Color.fromARGB(255, 10, 206, 112),
                Color.fromARGB(255, 28, 102, 229),
                Color.fromARGB(255, 106, 33, 208)
              ]),
              neonGradient: LinearGradient(colors: [
                Colors.greenAccent.shade200,
                Colors.blueAccent.shade400,
                Colors.purple.shade800,
              ]),
              strokeCap: StrokeCap.round,
              innerFillColor: Colors.black12,
              backgroudColor: Colors.grey.shade100,
              neonColor: Colors.blue.shade900),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(children: [
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: 1.6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: (_start)
                              ? Icon(Icons.pause, size: 35)
                              : Icon(Icons.play_arrow, size: 35),
                          color: Colors.white,
                          onPressed: () {
                            if (_start) {
                              setState(() {
                                controller.pause();
                                _start = false;
                              });
                            } else {
                              setState(() {
                                controller.resume();
                                _start = true;
                              });
                            }
                          }),
                      SizedBox(
                        width: 95,
                        height: 40,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              controller.restart();
                              setState(() {
                                _start = true;
                              });
                            },
                            child: Text(
                              "Restart",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
