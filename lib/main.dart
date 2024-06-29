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
      child: const MaterialApp(
        title: "Todo List Bloc",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
