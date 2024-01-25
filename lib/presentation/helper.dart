import 'package:intl/intl.dart';

String timestampConvert(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return '$formattedDate\n$formattedTime';
}

