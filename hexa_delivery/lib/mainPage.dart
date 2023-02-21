import 'package:flutter/material.dart';
import 'dart:async';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

List<int> groupTotalTime = [221, 317, 500];

List<Duration> countdownDurations = [
  Duration(minutes: groupTotalTime[0] ~/ 60, seconds: groupTotalTime[0] % 60),
  Duration(minutes: groupTotalTime[1] ~/ 60, seconds: groupTotalTime[1] % 60),
  Duration(minutes: groupTotalTime[2] ~/ 60, seconds: groupTotalTime[2] % 60)
];

class _MyPageState extends State<MyPage> {
  int whatTimer = 0;
  List<Timer> timers = [];

  @override
  Widget build(BuildContext context) {
    List<String> categoryData = [
      '치킨',
      '피자',
      '양식',
      '한식',
      '중식',
      '일식',
      '분식',
      '야식',
      '간식',
    ];
    Widget buildAppBarTitle(String text) {
      return Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget buildSubTitle(String text) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff637677),
            ),
          ),
        ),
      );
    }

    Widget buildGroupListText(String text) {
      return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }

    List<ElevatedButton> categoryButton = categoryData.map((item) {
      return new ElevatedButton(
        onPressed: () {},
        child: new Text(item,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color(0xFFC6EDEF),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            side: MaterialStateProperty.all(
              BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)))),
      );
    }).toList();

    GridView categoryGrid = GridView.count(
      crossAxisCount: 3,
      children: categoryButton,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
    );
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Column(
          children: [
            buildAppBarTitle('HeXA'),
            buildAppBarTitle('DELIVERY'),
          ],
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle),
            color: Colors.black,
            iconSize: 30,
          ),
        ],
        backgroundColor: Color(0xff81ccd1),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSubTitle('임박한 모임'),
            Container(
              height: 100,
              // child: Center(child: Text('아직 모임이 없어요. 모임을 시작해보세요!')),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildGroupListText('1  BHC 구영점'),
                          TimerWidget1(),
                          // Text(
                          //   '03:41',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20,
                          //     color: Colors.red,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildGroupListText('2  피자나라 치킨공주 ···'),
                          TimerWidget2(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildGroupListText('3'),
                          buildGroupListText('-'),
                          TimerWidget3(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildSubTitle('카테고리'),
            Container(
              child: categoryGrid,
              height: 380,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFF81CCD1),
      ),
    );
  }
}

class TimerWidget1 extends StatefulWidget {
  const TimerWidget1({super.key});

  @override
  State<TimerWidget1> createState() => _TimerWidget1State();
}

class _TimerWidget1State extends State<TimerWidget1> {
  // Duration duration = Duration();
  Duration duration = Duration();
  Timer? timer;

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    setState(() => duration = countdownDurations[0]);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      // '${duration.inSeconds}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.red,
      ),
    );
  }
}

class TimerWidget2 extends StatefulWidget {
  const TimerWidget2({super.key});

  @override
  State<TimerWidget2> createState() => _TimerWidget2State();
}

class _TimerWidget2State extends State<TimerWidget2> {
  Duration duration = Duration();
  Timer? timer;

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    setState(() => duration = countdownDurations[1]);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      // '${duration.inSeconds}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.red,
      ),
    );
  }
}

class TimerWidget3 extends StatefulWidget {
  const TimerWidget3({super.key});

  @override
  State<TimerWidget3> createState() => _TimerWidget3State();
}

class _TimerWidget3State extends State<TimerWidget3> {
  Duration duration = Duration();
  Timer? timer;

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    setState(() => duration = countdownDurations[2]);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      // '${duration.inSeconds}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.red,
      ),
    );
  }
}