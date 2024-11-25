part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  @override
  List<Object> get props => [];
}

class GetToDos extends TodoEvent {}

class AddToDo extends TodoEvent {
  final ToDo toDo;

  AddToDo({required this.toDo});
}

class DeleteToDo extends TodoEvent {
  final String id;

  DeleteToDo({required this.id});

  @override
  List<Object> get props => [id];
}
