import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: isDarkTheme ? Colors.black : Colors.deepPurple,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        disabledColor: Colors.grey,
        cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: isDarkTheme ? Colors.white : Colors.black),
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: isDarkTheme ? Colors.white : Colors.black),
        bottomNavigationBarTheme: Theme.of(context)
            .bottomNavigationBarTheme
            .copyWith(
                backgroundColor:
                    isDarkTheme ? Colors.black : Colors.deepPurple));
  }
}
