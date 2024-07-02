import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/model/todo_class.dart';
import 'package:todo_list_bloc/database/database_helper.dart';

class ListCubit extends Cubit<List<Todo>> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  ListCubit() : super([]) {
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await _dbHelper.fetchTodos();
    emit(todos);
  }

  Future<List<Todo>> searchTodos(String query) async {
    final todos = await _dbHelper.fetchTodos();
    return todos.where((todo) => todo.title.contains(query)).toList();
  }

  void addToList(Todo todoItem) async {
    await _dbHelper.insertTodo(todoItem);
    emit(List.from(state)..add(todoItem));
  }

  void removeFromList(String title) async {
    await _dbHelper.deleteTodo(title);
    emit(List.from(state)..removeWhere((item) => item.title == title));
  }

  void updateTodoStatus(int id, bool isDone) async {
    await _dbHelper.updateTodoStatus(id, isDone);

    final updatedList = state.map((todo) {
      return todo.id == id ? todo.copyWith(isDone: isDone) : todo;
    }).toList();
    emit(updatedList);
  }

  int get listLength => state.length;

  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    debugPrint(listLength.toString());
    if (change.currentState.isNotEmpty) {
      debugPrint(change.currentState.last.title);
    }
  }
}
