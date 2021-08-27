import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  static formatSecondDate(String date) {
    DateTime dateTime = new DateFormat("dd-MM-yyyy HH:mm").parse(date);
    String day = DateFormat('EEEE').format(dateTime);
    switch (day) {
      case "Saturday":
        day = "Samedi";
        break;
      case "Monday":
        day = "Lundi";
        break;
      case "Thursday":
        day = "Mardi";
        break;
      case "Wednesday":
        day = "mercredi";
        break;
      case "Tuesday":
        day = "Jeudi";
        break;
      case "Friday":
        day = "Vendredi";
        break;
      case "Sunday":
        day = "Dimanche";
        break;
    }
    day += " ";
    day += dateTime.day.toString();
    day += " ";
    String month = "";
    switch (dateTime.month) {
      case 1:
        month = "Janvier";
        break;
      case 2:
        month = "Février";
        break;
      case 3:
        month = "Mars";
        break;
      case 4:
        month = "Avril";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Juin";
        break;
      case 7:
        month = "Juillet";
        break;
      case 8:
        month = "Août";
        break;
      case 9:
        month = "Septembre";
        break;
      case 10:
        month = "Octobre";
        break;
      case 11:
        month = "Novembre";
        break;
      case 12:
        month = "Décembre";
        break;
    }
    day += month;
    day += " - ";
    day += (DateFormat('HH:mm').format(dateTime)).replaceAll(":", "h");
    return day;
  }

  static formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String day = DateFormat('EEEE').format(dateTime);
    switch (day) {
      case "Saturday":
        day = "Samedi";
        break;
      case "Monday":
        day = "Lundi";
        break;
      case "Thursday":
        day = "Mardi";
        break;
      case "Wednesday":
        day = "mercredi";
        break;
      case "Tuesday":
        day = "Jeudi";
        break;
      case "Friday":
        day = "Vendredi";
        break;
    }
    day += " ";
    day += dateTime.day.toString();
    day += " ";
    String month = "";
    switch (dateTime.month) {
      case 1:
        month = "Janvier";
        break;
      case 2:
        month = "Février";
        break;
      case 3:
        month = "Mars";
        break;
      case 4:
        month = "Avril";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Juin";
        break;
      case 7:
        month = "Juillet";
        break;
      case 8:
        month = "Août";
        break;
      case 9:
        month = "Septembre";
        break;
      case 10:
        month = "Octobre";
        break;
      case 11:
        month = "Novembre";
        break;
      case 12:
        month = "Décembre";
        break;
    }
    day += month;
    day += " - ";
    day += (DateFormat('HH:mm').format(dateTime)).replaceAll(":", "h");
    return day;
  }

  static formatDateDMY(String date) {
    DateTime dateTime = DateTime.parse(date);
    String day = "";
    day += dateTime.day.toString();
    day += " ";
    print("starting " + day);
    String month = "";
    switch (dateTime.month) {
      case 1:
        month = "Janvier";
        break;
      case 2:
        month = "Février";
        break;
      case 3:
        month = "Mars";
        break;
      case 4:
        month = "Avril";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Juin";
        break;
      case 7:
        month = "Juillet";
        break;
      case 8:
        month = "Août";
        break;
      case 9:
        month = "Septembre";
        break;
      case 10:
        month = "Octobre";
        break;
      case 11:
        month = "Novembre";
        break;
      case 12:
        month = "Décembre";
        break;
    }
    day += month;
    day += " ";
    day += dateTime.year.toString();
    return day;
  }

  static addHoursAndMinutesPrecision(TimeOfDay time) {
    String formattedTime = " à ";
    if (time.hour.toString().length != 2) {
      formattedTime += "0";
    }
    formattedTime += time.hour.toString() + ":";
    if (time.minute.toString().length != 2) {
      formattedTime += "0";
    }
    formattedTime += time.minute.toString();
    return formattedTime;
  }
}
