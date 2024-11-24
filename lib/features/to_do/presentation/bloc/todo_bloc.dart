import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/to_do/data/models/to_do_model.dart';
import 'package:todo/features/to_do/data/repository/to_do_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  List<ToDo> todos = [];

  TodoBloc({TodoRepository? todoRepository})
      : _todoRepository = todoRepository ?? TodoRepository(),
        super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if (event is GetToDos) {
        emit(TodoLoading());
        try {
          final result = await _todoRepository.fetchToDos();
          todos = result;
          emit(TodoLoaded(todos));
        } catch (e) {
          emit(ToDoError(e.toString()));
        }
      }
    });
  }
}
