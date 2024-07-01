import 'package:flutter/material.dart';
import 'package:todo_list_bloc/bloc/list_cubit.dart';
import 'package:todo_list_bloc/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => ListCubit(),
      child: MaterialApp(
        title: "Todo",
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "RedHat"),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
