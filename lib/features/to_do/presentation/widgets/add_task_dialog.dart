import 'package:flutter/material.dart';
import 'package:todo/features/to_do/data/models/to_do_model.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function(ToDo) onAddTask;

  AddTaskDialog({required this.onAddTask, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a task to your List'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            decoration:
            const InputDecoration(hintText: 'Enter task description'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('ADD'),
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty) {
              onAddTask(ToDo(
                title: _titleController.text,
                description: _descriptionController.text,
              ));
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter both title and description')),
              );
            }
          },
        ),
      ],
    );
  }
}
