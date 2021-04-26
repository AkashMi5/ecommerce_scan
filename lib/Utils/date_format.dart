
 import 'package:flutter/cupertino.dart';

class DateFormatShop {



  static changeFormat(String datetime){
    String month ;
    String AMPM ;

    String str1 = datetime;
    List<String> newStr = str1.split(' ') ;

    String onlyDate = newStr[0];
    String onlyTime  = newStr[1] ;

    if(newStr.length > 2){
       AMPM = newStr[2] ;
    }

    else {
      AMPM = '' ;
    }


    List<String> timeWithoutSeconds = onlyTime.split(':') ;
    String hrs = timeWithoutSeconds[0];
    String min = timeWithoutSeconds[1] ;

    List<String> Str2 = onlyDate.split('-');

    String dateOfMonth = Str2[0] ;

    String monthNumber = Str2[1] ;

    String year = Str2[2] ;

    switch(monthNumber) {
      case'01' :
        month = "January";
        break ;

      case'02' :
        month = "February";
        break ;

      case'03' :
        month = "March";
        break ;

      case'04' :
        month = "April";
        break ;

      case'05' :
        month = "June";
        break ;

      case'06' :
        month = "July";
        break ;

      case'07' :
        month = "August";
        break ;

      case'08' :
        month = "September";
        break ;

      case'09' :
        month = "August";
        break ;

      case'10' :
        month = "October";
        break ;

      case'11' :
        month = "November";
        break ;

      case'12' :
        month = "December";
        break ;

      default:
        month = "JanFeb" ;
            break;
    }

       return [dateOfMonth + " " + month + " " + year, month + " " + year, month, year, onlyTime + " " + AMPM, hrs + " " + min] ;
  }

 }









/*
 import 'package:flutter/material.dart';

 String dateFormat(String date){

   int date;
   int month;
   int year;
   int nextDate;
   int nextMonth;
   int nextYear;

   List<String> yearMonthDateSplit = date.split('.') ;

   date = int.parse(yearMonthDateSplit[2]);
   month = int.parse(yearMonthDateSplit[1]);
   year = int.parse(yearMonthDateSplit[0]);

   switch(month){
     case 1 :
     case 3 :
     case 5 :
     case 7 :
     case 8 :
     case 10 :
     case 12 :
       if(date <= 25){
         nextDate = date + 6 ;
         nextMonth = month ;
         nextYear = year ;
       }

       else {
         int diff = 31 - date;
         nextDate = 6 - diff  ;

         if()



       }


   }



 }*/
