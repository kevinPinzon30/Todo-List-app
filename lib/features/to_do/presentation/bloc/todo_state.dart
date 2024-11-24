part of 'todo_bloc.dart';

class TodoState {
  const TodoState();

  TodoState copyWith() => const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<ToDo> toDos;

  const TodoLoaded(this.toDos);

  @override
  List<Object?> get props => [toDos];
}

class ToDoError extends TodoState {
  final String message;

  const ToDoError(this.message);

  @override
  List<Object?> get props => [message];
}
