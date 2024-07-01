import 'package:flutter/material.dart';
import 'package:todo_list_bloc/bloc/list_cubit.dart';
import 'package:todo_list_bloc/bloc/theme_cubit.dart';
import 'package:todo_list_bloc/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/pages/settings_page.dart';
import 'package:todo_list_bloc/settings.dart';

// simple todo list app using bloc
void main() {
  runApp(const TodoList());
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListCubit>(create: (context) => ListCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) => MaterialApp(
          title: "Todo",
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          routes: {
            "/home": (context) => const HomePage(),
            "/settings": (context) => const SettingsPage(),
          },
        ),
      ),
    );
  }
}
