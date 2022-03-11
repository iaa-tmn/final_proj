import 'package:flutter/material.dart';

ThemeData globalThemes (bool dTheme){
  return ThemeData(
    //primaryColor: Colors.amber,
      colorScheme: ColorScheme.fromSwatch(

        brightness: dTheme? Brightness.dark:Brightness.light,
        primarySwatch: Colors.blue,
      ).copyWith(),
      textTheme: const TextTheme(
        headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        headline4: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        headline6: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        bodyText1: TextStyle(fontSize: 10, color: Colors.black),

      )
  );
}
InputBorder borderStyle ()
{
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      borderSide: BorderSide(
          color: Colors.blueGrey,
          width: 1
      )
  );
}

InputBorder focusedBorderStyle ()
{
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 2
      )
  );
}

