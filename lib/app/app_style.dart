import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

enum AppTheme {
  lightTheme,
  darkTheme
}

class AppStyle {

  static ThemeData lightTheme(BuildContext context){
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: Colors.red,
      primaryColorLight: Utils.darkenColor(primaryColor),
      primaryColorDark: Utils.darkenColor(primaryColor),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      canvasColor: Colors.grey,
      cardColor: Colors.white,
      shadowColor: const Color(0xFFF0F0F0),
      appBarTheme: AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconTheme.of(context).copyWith(color: primaryColor, size: 34, ),
          centerTitle: true,
          elevation: 0
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.black.withOpacity(0.8), fontFamily: 'Poppins'
      ),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Utils.materialColor(primaryColor),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        fillColor: Colors.grey.withOpacity(0.2),
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: promptColor,
        ),
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: Colors.white
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(
          color: Colors.white
      ),
      buttonTheme: ButtonTheme.of(context).copyWith(buttonColor: primaryColor),
      radioTheme: RadioTheme.of(context).copyWith(
          fillColor: MaterialStateProperty.all(primaryColor)),
      checkboxTheme: CheckboxTheme.of(context).copyWith(
          fillColor: MaterialStateProperty.all(primaryColor)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        selectedLabelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Utils.darkenColor(primaryColor),
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: promptColor,
        ),
        selectedIconTheme: const IconThemeData().copyWith(size: 18),
        unselectedIconTheme: const IconThemeData().copyWith(size: 18),
        unselectedItemColor: promptColor,
        selectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        elevation: 16,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Utils.darkenColor(primaryColor)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(blunt),
              )),
              textStyle: MaterialStateProperty.all(TextStyle(
                  color: Utils.darkenColor(primaryColor),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontSize: 14
              ))
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Utils.darkenColor(primaryColor)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(blunt),
              )),
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ))
          )
      ),
    );
  }


  static ThemeData darkTheme(BuildContext context){
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: Colors.red,
      primaryColorLight: Utils.darkenColor(primaryColor),
      primaryColorDark: Utils.darkenColor(primaryColor),
      scaffoldBackgroundColor: const Color(0xFF222222),
      backgroundColor: Colors.grey,
      canvasColor: Colors.grey,
      cardColor: const Color(0xFF222222),
      shadowColor: const Color(0xFF444444),
      appBarTheme: AppBarTheme(
          color: const Color(0xFF222222),
          foregroundColor: Colors.white,
          iconTheme: IconTheme.of(context).copyWith(color: primaryColor, size: 34, ),
          centerTitle: true,
          elevation: 0
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white.withOpacity(0.8), fontFamily: 'Poppins'
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Utils.materialColor(primaryColor),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: promptColor,
        ),
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        prefixIconColor: Colors.white,
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
      ),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: Colors.white
      ),
      buttonTheme: ButtonTheme.of(context).copyWith(buttonColor: primaryColor),
      radioTheme: RadioTheme.of(context).copyWith(
          fillColor: MaterialStateProperty.all(primaryColor)),
      checkboxTheme: CheckboxTheme.of(context).copyWith(
          fillColor: MaterialStateProperty.all(primaryColor)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: promptColor,
        ),
        selectedIconTheme: const IconThemeData().copyWith(size: 20),
        unselectedIconTheme: const IconThemeData().copyWith(size: 20),
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        selectedItemColor: primaryColor,
        backgroundColor: Colors.black,
        elevation: 16,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(blunt),
            )),
            textStyle: MaterialStateProperty.all(TextStyle(
              color: Utils.darkenColor(primaryColor),
              fontWeight: FontWeight.w600,
              fontSize: 14
            ))
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Utils.darkenColor(primaryColor)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(blunt),
              )),
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14
              ))
          )
      ),
    );
  }

}