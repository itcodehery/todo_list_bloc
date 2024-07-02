import 'package:flutter/material.dart';

ThemeForApp globalTheme = ThemeForApp.light;

enum ThemeForApp {
  light,
  dark,
}

ThemeData themeData(ThemeForApp theme) {
  switch (theme) {
    case ThemeForApp.light:
      return ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "RedHat",
      );
    case ThemeForApp.dark:
      return ThemeData(
        fontFamily: "RedHat",
        brightness: Brightness.dark,
        primaryColor: Colors.purple[800], // Primary color for dark mode
        scaffoldBackgroundColor:
            Colors.grey[900], // Background color for scaffold
        appBarTheme: const AppBarTheme(
          color: Colors.transparent, // AppBar color
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.purple[800]!,
          secondary: Colors.purpleAccent[400]!,
          surface: Colors.grey[800]!, // Surface color for cards, dialogs, etc.

          error: Colors.red[400]!, // Error color
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850], // Card background color
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple, // FAB background color
          foregroundColor: Colors.purple[100], // FAB icon/text color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[850], // Text field background color
          hintStyle: const TextStyle(color: Colors.white70), // Hint text color
          labelStyle:
              const TextStyle(color: Colors.white70), // Label text color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white70), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.purple),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white70, // Icon color
        ),
        dividerColor: Colors.grey[700], // Divider color
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.purple[600], // SnackBar background color
          contentTextStyle:
              const TextStyle(color: Colors.white), // SnackBar text color
          actionTextColor: Colors.purpleAccent[400], // SnackBar action color
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[850], // Dialog background color
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.grey[850], // Popup menu background color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:
              Colors.grey[900], // Bottom navigation bar background color
          selectedItemColor: Colors.purple[400], // Selected item color
          unselectedItemColor: Colors.white70, // Unselected item color
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.purple[400], // Tab bar selected text color
          unselectedLabelColor: Colors.white70, // Tab bar unselected text color
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.purple[400]!,
                width: 2.0,
              ),
            ),
          ),
        ),
      );

    default:
      return ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "RedHat",
      );
  }
}

final Map<String, dynamic> settings = {
  "theme": "light",
};
