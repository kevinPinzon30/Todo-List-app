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
    on<TodoEvent>((event, emit) {
      if (event is GetToDos) {
        getToDos();
      } else if (event is AddToDo) {
        addToDo(event);
      } else if (event is DeleteToDo) {
        deleteToDo(event);
      }
    });
  }

  getToDos() async {
    try {
      final result = await _todoRepository.fetchToDos();
      todos = result;
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  addToDo(AddToDo event) async {
    try {
      await _todoRepository.createToDo(event.toDo);
      getToDos();
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  deleteToDo(DeleteToDo event) async {
    try {
      await _todoRepository.deleteToDo(event.id);
      getToDos();
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
