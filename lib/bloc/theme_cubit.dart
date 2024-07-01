import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_bloc/settings.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(themeData(ThemeForApp.light)) {
    loadTheme();
  }

  void toggleTheme() => state == themeData(ThemeForApp.light)
      ? emit(themeData(ThemeForApp.dark))
      : emit(themeData(ThemeForApp.light));

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("isDark") ?? false;
    isDark
        ? emit(themeData(ThemeForApp.dark))
        : emit(themeData(ThemeForApp.light));
  }
}
