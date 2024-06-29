import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/bloc/list_cubit.dart';
import 'package:todo_list_bloc/model/todo_class.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Todo",
                  ),
                  controller: _todoController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  controller: _descController,
                ),
                ElevatedButton(
                  onPressed: () => _confirmAdd(context),
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Are you sure you want to add this todo?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _addTodo(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addTodo(BuildContext context) {
    final cubit = context.read<ListCubit>();
    cubit.addToList(Todo(
      title: _todoController.text,
      description: _descController.text,
      id: Random.secure().nextInt(999),
      createdOn: DateTime.now(),
    ));

    Navigator.of(context).pop(); // Close the confirmation dialog
    Navigator.of(context).pop(); // Close the AddTodoPage
  }
}
