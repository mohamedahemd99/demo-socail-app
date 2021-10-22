import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: "Jannah"),
      titleSpacing: 20.0,
        backgroundColor:Colors.white ,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backwardsCompatibility: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        brightness: Brightness.dark,
        textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black))
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey),
    floatingActionButtonTheme:FloatingActionButtonThemeData(backgroundColor: defaultColor),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
        subtitle1: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black,height: 1.3),
    ),
);


ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: defaultColor,
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: "Jannah"),
        titleSpacing: 20.0,
        backgroundColor:Colors.black ,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backwardsCompatibility: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        brightness: Brightness.dark,
        textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black))
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        backgroundColor: defaultColor,
        unselectedItemColor: Colors.grey),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color:Colors.white),
        subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color:Colors.white,
            height: 1.3
        ),
    ),
);
