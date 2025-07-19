import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:taskzen/features/shared/enum/enum.dart';
import 'package:taskzen/features/shared/error/failure.dart';
import 'package:taskzen/features/shared/mock/mock_data.dart';
import 'package:taskzen/features/task_board/domain/entities/task.dart';
import 'package:taskzen/features/task_board/domain/entities/user.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/create_task.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/filter_tasks.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/get_task_by_id.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/get_tasks.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/task_use_cases.dart';
import 'package:taskzen/features/task_board/domain/usecases/task/update_task.dart';
import 'package:taskzen/features/task_board/presentation/blocs/task/task_bloc.dart';

/// Unit test against below events written as it's been used in feature
/// - LoadTasksEvent
/// - AddTaskEvent
/// - UpdateTaskEvent
/// - FilterTasksEvent
///
///
/// Unit test against below events not written as it's not been used in feature
/// - GetTaskByIdEvent

class MockGetTasks extends Mock implements GetTasks {}

class MockCreateTask extends Mock implements CreateTask {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockGetTaskById extends Mock implements GetTaskById {}

class MockFilterTasks extends Mock implements FilterTasks {}

void main() {
  late TaskBloc taskBloc;
  late TaskUseCases taskUseCases;
  late MockGetTasks mockGetTasks;
  late MockCreateTask mockCreateTask;
  late MockUpdateTask mockUpdateTask;
  late MockGetTaskById mockGetTaskById;
  late MockFilterTasks mockFilterTasks;
  late List<Task> mockTaskList;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockCreateTask = MockCreateTask();
    mockUpdateTask = MockUpdateTask();
    mockGetTaskById = MockGetTaskById();
    mockFilterTasks = MockFilterTasks();
    taskUseCases = TaskUseCases(
      getTasks: mockGetTasks,
      createTask: mockCreateTask,
      updateTask: mockUpdateTask,
      getTaskById: mockGetTaskById,
      filterTasks: mockFilterTasks,
    );

    taskBloc = TaskBloc(taskUseCases);

    mockTaskList = mockTaskModelist.map((e) => e.toEntity()).toList();
  });

  test('initial State should be TaskLoading', () {
    expect(taskBloc.state, equals(TaskLoading()));
  });

  group('LoadTasksEvent', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when LoadTasksEvent is fetched and success',
      build: () {
        when(
          () => taskUseCases.getTasks(),
        ).thenAnswer((_) async => Either.right(mockTaskList));
        return taskBloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () => [TaskLoading(), TaskLoaded(mockTaskList)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when LoadTasksEvent is fetched and fail',
      build: () {
        when(() => taskUseCases.getTasks()).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to get tasks')),
        );
        return taskBloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () => [TaskLoading(), TaskError('Failed to get tasks')],
    );
  });

  group('AddTaskEvent', () {
    late Task newTask;
    late List<Task> newMockTaskList;

    setUp(() {
      newTask = Task(
        id: 6,
        title: 'Test title',
        status: TaskStatus.todo,
        priority: TaskPriority.low,
        createdAt: DateTime.now(),
      );
      newMockTaskList = [...mockTaskList, newTask];
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when AddTaskEvent is added and success',
      build: () {
        when(
          () => taskUseCases.getTasks(),
        ).thenAnswer((_) async => Either.right(newMockTaskList));
        when(
          () => taskUseCases.createTask(newTask),
        ).thenAnswer((_) async => Either.right(null));
        return taskBloc;
      },
      act: (bloc) => bloc.add(AddTaskEvent(newTask)),
      expect: () => [TaskLoading(), TaskLoaded(newMockTaskList)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskError] when AddTaskEvent is added and fail',
      build: () {
        when(() => taskUseCases.createTask(newTask)).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to add task')),
        );
        return taskBloc;
      },
      act: (bloc) => bloc.add(AddTaskEvent(newTask)),
      expect: () => [TaskError('Failed to add task')],
    );
  });

  group('UpdateTaskEvent', () {
    late Task updateTask;
    late List<Task> updateMockTaskList;

    setUp(() {
      updateTask = mockTaskList.first.copyWith(priority: TaskPriority.high);
      updateMockTaskList = [...mockTaskList];
      updateMockTaskList.replaceRange(0, 1, [updateTask]);
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when UpdateTaskEvent is updated and success',
      build: () {
        when(
          () => taskUseCases.getTasks(),
        ).thenAnswer((_) async => Either.right(updateMockTaskList));
        when(
          () => taskUseCases.updateTask(updateTask),
        ).thenAnswer((_) async => Either.right(null));
        return taskBloc;
      },
      act: (bloc) => bloc.add(UpdateTaskEvent(updateTask)),
      expect: () => [TaskLoading(), TaskLoaded(updateMockTaskList)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskError] when UpdateTaskEvent is updated and fail',
      build: () {
        when(() => taskUseCases.updateTask(updateTask)).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to update task')),
        );
        return taskBloc;
      },
      act: (bloc) => bloc.add(UpdateTaskEvent(updateTask)),
      expect: () => [TaskError('Failed to update task')],
    );
  });

  group('FilterTasksEvent', () {
    late String searchTitle;
    late List<Task> searchTasks;
    late User selectedUser;
    setUp(() {
      searchTitle = 'b';
      searchTasks = mockTaskList
          .where((task) => task.title.toLowerCase().contains(searchTitle))
          .toList();
      selectedUser = mockUserModelList
          .singleWhere((element) => element.id == 3)
          .toEntity();
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when FilterTasksEvent is filter by title',
      build: () {
        when(
          () => taskUseCases.filterTasks(title: searchTitle),
        ).thenAnswer((_) async => Either.right(searchTasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(FilterTasksEvent(title: searchTitle)),
      expect: () => [TaskLoading(), TaskLoaded(searchTasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when FilterTasksEvent is filter by title & priority',
      build: () {
        searchTasks = searchTasks
            .where((task) => task.priority == TaskPriority.high)
            .toList();
        when(
          () => taskUseCases.filterTasks(
            title: searchTitle,
            priorities: [TaskPriority.high],
          ),
        ).thenAnswer((_) async => Either.right(searchTasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(
        FilterTasksEvent(title: searchTitle, priorities: [TaskPriority.high]),
      ),
      expect: () => [TaskLoading(), TaskLoaded(searchTasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when FilterTasksEvent is filter by title, priority and assignee',
      build: () {
        searchTasks = searchTasks
            .where(
              (task) =>
                  task.priority == TaskPriority.high &&
                  task.assignee.value?.id == selectedUser.id,
            )
            .toList();
        when(
          () => taskUseCases.filterTasks(
            title: searchTitle,
            priorities: [TaskPriority.high],
            assignees: [selectedUser],
          ),
        ).thenAnswer((_) async => Either.right(searchTasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(
        FilterTasksEvent(
          title: searchTitle,
          priorities: [TaskPriority.high],
          assignees: [selectedUser],
        ),
      ),
      expect: () => [TaskLoading(), TaskLoaded(searchTasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskError] when FilterTasksEvent is filter by title and fail',
      build: () {
        when(() => taskUseCases.filterTasks(title: searchTitle)).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to filter tasks')),
        );
        return taskBloc;
      },
      act: (bloc) => bloc.add(FilterTasksEvent(title: searchTitle)),
      expect: () => [TaskLoading(), TaskError('Failed to filter tasks')],
    );
  });
}
