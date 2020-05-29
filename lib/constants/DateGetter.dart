import 'dart:core';
import 'package:intl/intl.dart';
String getStrToday() {
  var today = DateFormat().add_yMMMMd().format(DateTime.now());
  var strDay = today.split(" ")[1].replaceFirst(',', '');
  if (strDay == '1') {
    strDay = strDay + "st";
  } else if (strDay == '2') {
    strDay = strDay + "nd";
  } else if (strDay == '3') {
    strDay = strDay + "rd";
  } else {
    strDay = strDay + "th";
  }
  var strMonth = today.split(" ")[0];
  var strYear = today.split(" ")[2];
  return "$strDay $strMonth $strYear";
}