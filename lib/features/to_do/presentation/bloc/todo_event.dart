part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  @override
  List<Object> get props => [];
}

class GetToDos extends TodoEvent {}
