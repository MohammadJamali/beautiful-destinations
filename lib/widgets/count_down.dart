import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  final int seconds;
  final AsyncCallback onFinished;
  final Widget Function(int count, BuildContext context) onCountDown;

  const CountDownWidget({
    super.key,
    required this.seconds,
    required this.onCountDown,
    required this.onFinished,
  });

  @override
  CountDownWidgetState createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget> {
  late int _seconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        if (_timer.isActive) _timer.cancel();
        return;
      }

      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
          widget.onFinished();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.onCountDown(_seconds, context);
}

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Timeline(),
//       ),
//     );
//   }
// }

// class Timeline extends StatefulWidget {
//   @override
//   _TimelineState createState() => _TimelineState();
// }

// class _TimelineState extends State<Timeline> {
//   List<Box> boxes = [
//     Box(title: 'Box 1'),
//     Box(title: 'Box 2'),
//     Box(title: 'Box 3'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: boxes.length,
//       itemBuilder: (context, index) {
//         final box = boxes[index];
//         return Draggable(
//           data: box,
//           child: box,
//           feedback: box,
//           childWhenDragging: Container(),
//         );
//       },
//     );
//   }
// }

// class Box extends StatelessWidget {
//   final String title;

//   const Box({Key key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 50,
//       color: Colors.blue,
//       child: Center(
//         child: Text(title),
//       ),
//     );
//   }
// }
