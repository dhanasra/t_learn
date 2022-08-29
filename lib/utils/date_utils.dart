import 'package:easy_localization/easy_localization.dart';

class DateTimeUtils {

  static String currentDateTimeInMillis(){
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String formatDate(int timeInMillis){
    return DateFormat("MMM d").format(DateTime.fromMicrosecondsSinceEpoch(timeInMillis));
  }

  static String getToday(String format){
    return DateFormat(format).format(DateTime.now());
  }

  static String getDateFromMonths(String mon){
    
    int months = int.parse(mon);
    
    if(months>=12){
      return " ${months~/12}  Year";
    }else{
      return " ${months%12}  Months";
    }
  }

  static String getValidityInMilliseconds(String mon){
    int months = int.parse(mon);
    DateTime date = DateTime.now();
    DateTime dateTime = DateTime(date.year, date.month+months, date.day);
    return dateTime.millisecondsSinceEpoch.toString();
  }
  
  static String getValidity(String mon){
    int months = int.parse(mon);
    DateTime date = DateTime.now();
    DateTime dateTime = DateTime(date.year, date.month+months, date.day);
    return DateFormat("MMM d, yyyy").format(DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch));
  }

  static String getTimerFormat(int sec){
    int minutes = sec~/60;
    int seconds = sec%60;

    return "${minutes.toString().padLeft(2,"0")} : ${seconds.toString().padLeft(2,"0")}";
  }

  static String getTimerFormat2(String source){
    int sec = int.parse(source);
    int minutes = sec~/60;
    int seconds = sec%60;

    if(minutes>0){
      if(seconds>0){
        return "$minutes min $seconds sec";
      }else{
        return "$minutes min";
      }
    }else{
      return "$seconds sec";
    }
  }
}