import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:intl/intl.dart';

String? convertDateForm(DateTime tm) {
  DateTime today = DateTime.now();
  Duration oneDay = const Duration(days: 1);
  Duration twoDay = const Duration(days: 2);
  Duration oneWeek = const Duration(days: 7);
  String? month;
  switch (tm.month) {
    case 1:
      month = "jan";
      break;
    case 2:
      month = "feb";
      break;
    case 3:
      month = "mar";
      break;
    case 4:
      month = "apr";
      break;
    case 5:
      month = "may";
      break;
    case 6:
      month = "jun";
      break;
    case 7:
      month = "jul";
      break;
    case 8:
      month = "aug";
      break;
    case 9:
      month = "sep";
      break;
    case 10:
      month = "oct";
      break;
    case 11:
      month = "nov";
      break;
    case 12:
      month = "dec";
      break;
  }

  Duration difference = today.difference(tm);
  if (difference.compareTo(const Duration(minutes: 1)) < 1) {
    return 'Now';
    // ignore: prefer_const_constructors
  } else if (difference.compareTo(Duration(hours: 1)) < 1) {
    // return '${difference.inMinutes} minute';
    return DateFormat.jm().format(tm);
  } else if (difference.compareTo(oneDay) < 1) {
    return DateFormat.jm().format(tm);
    // return '${difference.inHours} hours';
  } else if (difference.compareTo(twoDay) < 1) {
    return "yesterday";
  } else if (difference.compareTo(oneWeek) < 1) {
    switch (tm.weekday) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thursday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
    }
  } else if (tm.year == today.year) {
    return '${tm.day} $month';
  } else {
    return '${tm.day} $month ${tm.year}';
  }
  return null;
}

String chatId(String id1, String id2) {
  if (id1.compareTo(id2) > 0) {
    return '$id1-$id2';
  } else {
    return '$id2-$id1';
  }
}

class MsgDate extends StatefulWidget {
  const MsgDate({Key? key, this.date, this.size = 12, this.color = greyColor})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final date;
  final double size;
  final Color color;
  @override
  State<MsgDate> createState() => _MsgDateState();
}

class _MsgDateState extends State<MsgDate> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${convertDateForm(widget.date)}',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
