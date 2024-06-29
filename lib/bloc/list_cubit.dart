import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/model/todo_class.dart';

class ListCubit extends Cubit<List<Todo>> {
  ListCubit() : super([]);

  void addToList(Todo todoItem) => emit(List.from(state)..add(todoItem));

  void removeFromList(String title) =>
      emit(List.from(state)..removeWhere((item) => item.title == title));

  void updateTodoStatus(int id, bool isDone) {
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
