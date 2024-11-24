import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/to_do/data/models/to_do_model.dart';
import 'package:todo/features/to_do/presentation/widgets/to_do_card.dart';

import '../bloc/todo_bloc.dart';

class TodoList extends StatelessWidget {
  final List<ToDo> toDosList = [];

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()..add(GetToDos()),
        ),
      ],
      child: MultiBlocListener(
          listeners: [
            BlocListener<TodoBloc, TodoState>(
              listener: (context, state) {},
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('To-Do List'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoaded) {
                      toDosList.addAll(state.toDos);
                    }
                    return _toDoListWidget();
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _displayDialog(context),
              tooltip: 'Add Item',
              child: Icon(Icons.add),
            ),
          )),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    // setState(() {
    //   _todoList.add(title);
    // });
    _textFieldController.clear();
  }

  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your List'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Expanded _toDoListWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: toDosList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(toDosList[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              toDosList.removeAt(index);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Task deleted')));
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white, size: 40),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TodoCard(
                toDo: toDosList[index],
                onDelete: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
