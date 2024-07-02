import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:todo_list_bloc/bloc/list_cubit.dart';
import 'package:todo_list_bloc/database/database_helper.dart';
import 'package:todo_list_bloc/model/todo_class.dart';
import 'package:todo_list_bloc/pages/add_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // goto settings
                Navigator.of(context).pushNamed("/settings");
              },
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      body: BlocBuilder<ListCubit, List<Todo>>(
        builder: (context, listOfTodo) {
          final completedTodo =
              listOfTodo.where((element) => element.isDone).toList();
          completedTodo.sort((a, b) => b.createdOn.compareTo(a.createdOn));
          final incompleteTodo =
              listOfTodo.where((element) => !element.isDone).toList();
          incompleteTodo.sort((a, b) => b.createdOn.compareTo(a.createdOn));
          return listOfTodo.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: incompleteTodo.length,
                        itemBuilder: (context, index) {
                          final item = incompleteTodo[index];
                          return TodoListTile(item: item);
                        },
                      ),
                      completedTodo.isNotEmpty
                          ? const ListTile(
                              title: Text(
                                "Completed",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            )
                          : const SizedBox(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: completedTodo.length,
                          itemBuilder: (context, index) {
                            final item = completedTodo[index];
                            return TodoListTile(item: item);
                          }),
                    ],
                  ),
                )
              : const Center(
                  child: Text("Add something to do later!"),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddTodoPage();
            }));
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Item")),
    );
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.item,
  });

  final Todo item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: item.isDone,
          onChanged: (value) {
            if (value != null) {
              context.read<ListCubit>().updateTodoStatus(
                    item.id,
                    value,
                  );
            }
          }),
      trailing: IconButton(
          onPressed: () {
            context.read<ListCubit>().removeFromList(item.title);
          },
          icon: const Icon(Icons.delete_outline)),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.combine([
            TextDecoration.none,
            item.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ]),
        ),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 16,
            color: Colors.purple.shade300,
          ),
          const SizedBox(width: 4),
          Text(GetTimeAgo.parse(item.createdOn),
              style: TextStyle(color: Colors.purple.shade300)),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(item.icon,
                        size: 36, color: Colors.purple.shade300),
                  ),
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  item.description != ""
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.description),
                        )
                      : const SizedBox(),
                  Divider(
                    color: Colors.grey.withAlpha(50),
                  ),
                  Text(
                      "${item.createdOn.hour}:${item.createdOn.minute} | ${item.createdOn.day}/${item.createdOn.month}/${item.createdOn.year}"),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          Colors.purple.shade300,
                          Colors.purple.shade600
                        ])),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: const WidgetStatePropertyAll(0),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                Colors.transparent)),
                        onPressed: () {
                          context.read<ListCubit>().updateTodoStatus(
                                item.id,
                                !item.isDone,
                              );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                            "Mark as ${item.isDone ? "Incomplete" : "Complete"}")),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
