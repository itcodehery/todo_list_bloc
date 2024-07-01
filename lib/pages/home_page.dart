import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/bloc/list_cubit.dart';
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
      ),
      body: BlocBuilder<ListCubit, List<Todo>>(
        builder: (context, listOfTodo) {
          final completedTodo =
              listOfTodo.where((element) => element.isDone).toList();
          final incompleteTodo =
              listOfTodo.where((element) => !element.isDone).toList();
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
                                  context
                                      .read<ListCubit>()
                                      .removeFromList(item.title);
                                },
                                icon: const Icon(Icons.delete_outline)),
                            title: Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                                "${item.createdOn.day}/${item.createdOn.month}/${item.createdOn.year}",
                                style:
                                    TextStyle(color: Colors.purple.shade300)),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 8.0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item.title,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(item.description),
                                              const Divider(),
                                              Text(
                                                  "Created on: ${item.createdOn.day}/${item.createdOn.month}/${item.createdOn.year} at ${item.createdOn.hour}:${item.createdOn.minute}")
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          );
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
                                  context
                                      .read<ListCubit>()
                                      .removeFromList(item.title);
                                },
                                icon: const Icon(Icons.delete_outline)),
                            title: Text(
                              item.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            subtitle: Text(
                                "${item.createdOn.day}/${item.createdOn.month}/${item.createdOn.year}",
                                style:
                                    TextStyle(color: Colors.purple.shade300)),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 8.0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item.title,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(item.description),
                                              const Divider(),
                                              Text(
                                                  "Created on: ${item.createdOn.day}/${item.createdOn.month}/${item.createdOn.year} at ${item.createdOn.hour}:${item.createdOn.minute}")
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          );
                        },
                      ),
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
