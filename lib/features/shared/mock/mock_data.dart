import '../../task_board/data/models/task_model.dart';
import '../../task_board/data/models/user_model.dart';
import '../enum/enum.dart';

final mockUserModelList = <UserModel>[
  UserModel(
    id: 1,
    name: 'Alice',
    email: 'alice@gmail.com',
    role: Role.designer,
  ),
  UserModel(id: 2, name: 'Bob', email: 'bob@gmail.com', role: Role.developer),
  UserModel(
    id: 3,
    name: 'Charlie',
    email: 'charlie@gmail.com',
    role: Role.developer,
  ),
  UserModel(
    id: 4,
    name: 'Diana',
    email: 'diana@gmail.com',
    role: Role.productOwner,
  ),
  UserModel(id: 5, name: 'Rahul', email: 'rahul@gmail.com', role: Role.tester),
];

final mockTaskModelist = <TaskModel>[
  TaskModel(
      id: 1,
      title: 'Design login screen',
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.medium,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
    )
    ..assignee.value = mockUserModelList.singleWhere(
      (element) => element.id == 1,
    ),
  TaskModel(
    id: 2,
    title: 'Implement API integration',
    priority: TaskPriority.low,
    status: TaskStatus.todo,
    createdAt: DateTime.now(),
  ),
  TaskModel(
    id: 3,
    title: 'Fix logout bug',
    description:
        'As soon as user login and tries to logout showing Something went wrong',
    deadline: DateTime.now().add(Duration(days: 1)),
    priority: TaskPriority.high,
    status: TaskStatus.inProgress,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now(),
  )..assignee.value = mockUserModelList.singleWhere((element) => element.id == 2),
  TaskModel(
      id: 4,
      title: 'Update onboarding docs',
      priority: TaskPriority.low,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    )
    ..assignee.value = mockUserModelList.singleWhere(
      (element) => element.id == 4,
    ),
  TaskModel(
      id: 5,
      title: 'Refactor task bloc logic',
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.high,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    )
    ..assignee.value = mockUserModelList.singleWhere(
      (element) => element.id == 3,
    ),
];
