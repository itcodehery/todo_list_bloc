import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:todo_list_bloc/bloc/list_cubit.dart';
import 'package:todo_list_bloc/constants.dart';
import 'package:todo_list_bloc/model/todo_class.dart';

enum TodoIcon { important, tag, note, calendar }

final List<String> iconNames = ["Important", "Tag", "Note", "Event"];

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TodoIcon selected = TodoIcon.note;
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
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Todo",
                      hintText: "I will do great today!"),
                  controller: _todoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a todo";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                    hintText: "No matter the situation, I'll stay happy!",
                  ),
                  maxLines: 5,
                  controller: _descController,
                ),
                const SizedBox(height: 10),
                const Text("Choose an icon"),
                const SizedBox(height: 8),
                SegmentedButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  segments: _getSegments(),
                  selected: <TodoIcon>{selected},
                  onSelectionChanged: (selection) {
                    //toast
                    showToast(
                      "Selected: ${iconNames[selection.first.index]}",
                      context: context,
                      animation: StyledToastAnimation.fade,
                    );
                    setState(() {
                      selected = selection.first as TodoIcon;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _confirmAdd(context);
            }
          },
          child: const Icon(Icons.add),
        ));
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
      icon: choosableIcons[selected.index],
    ));

    Navigator.of(context).pop(); // Close the confirmation dialog
    Navigator.of(context).pop(); // Close the AddTodoPage
  }

  List<ButtonSegment> _getSegments() {
    return choosableIcons
        .map((icon) => ButtonSegment(
              value: TodoIcon.values[choosableIcons.indexOf(icon)],
              icon: Icon(icon),
            ))
        .toList();
  }
}
