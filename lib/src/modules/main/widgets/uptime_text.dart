import 'dart:async';

import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final int startTime;
  const TimeWidget({super.key, required this.startTime});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String uptime = '';
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final time = DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(widget.startTime),
        );
        if (time.inSeconds > 0 && time.inSeconds < 60) {
          uptime = '${time.inSeconds} seconds';
        } else if (time.inMinutes > 0 && time.inMinutes < 60) {
          uptime = '${time.inMinutes} minutes';
        } else if (time.inHours > 0 && time.inHours < 24) {
          uptime = '${time.inHours} hours';
        } else {
          uptime = 'less than a second';
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('Uptime: $uptime');
  }
}
