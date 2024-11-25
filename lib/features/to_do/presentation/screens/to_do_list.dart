import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/to_do/data/models/to_do_model.dart';
import 'package:todo/features/to_do/presentation/widgets/add_task_dialog.dart';
import 'package:todo/features/to_do/presentation/widgets/empty_state.dart';
import 'package:todo/features/to_do/presentation/widgets/to_do_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bloc/todo_bloc.dart';

class TodoList extends StatelessWidget {
  final TodoBloc todoBloc = TodoBloc();
  final List<ToDo> toDosList = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => todoBloc..add(GetToDos()),
        ),
      ],
      child: MultiBlocListener(
          listeners: [
            BlocListener<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is TodoLoaded) {
                  toDosList.clear();
                  toDosList.addAll(state.toDos);
                  _refreshController.refreshCompleted();
                }
                if (state is TodoError) {
                  _refreshController.refreshFailed();
                }
              },
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('To-Do List'),
            ),
            body: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state is TodoLoaded) {
                        toDosList.clear();
                        toDosList.addAll(state.toDos);
                      }

                      if (toDosList.isEmpty) {
                        return SliverFillRemaining(
                          child: EmptyStateCard(),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Dismissible(
                                key: Key(toDosList[index].id.toString()),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  deleteToDoItem(index, context);
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: TodoCard(
                                    toDo: toDosList[index],
                                    onDelete: () {
                                      deleteToDoItem(index, context);
                                    },
                                  ),
                                ),
                              );
                            },
                            childCount: toDosList.length,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTaskDialog(
                      onAddTask: (ToDo toDo) {
                        todoBloc.add(AddToDo(toDo: toDo));
                      },
                    );
                  },
                );
              },
              tooltip: 'Add Item',
              child: Icon(Icons.add),
            ),
          )),
    );
  }

  void _onRefresh() async {
    todoBloc.add(GetToDos());
  }

  deleteToDoItem(int index, BuildContext context) {
    try {
      todoBloc.add(DeleteToDo(id: toDosList[index].id!));
    } catch (e) {}
    toDosList.removeAt(index);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Task deleted')));
  }
}
