import '../../task_board/data/models/task_model.dart';
import '../../task_board/data/models/user_model.dart';
import '../enum/enum.dart';

final mockUserModelList = <UserModel>[
    UserModel(
      userId: 1,
      name: 'Alice',
      email: 'alice@gmail.com',
      role: Role.designer,
    ),
    UserModel(
      userId: 2,
      name: 'Bob',
      email: 'bob@gmail.com',
      role: Role.developer,
    ),
    UserModel(
      userId: 3,
      name: 'Charlie',
      email: 'charlie@gmail.com',
      role: Role.developer,
    ),
    UserModel(
      userId: 4,
      name: 'Diana',
      email: 'diana@gmail.com',
      role: Role.productOwner,
    ),
    UserModel(
      userId: 5,
      name: 'Rahul',
      email: 'rahul@gmail.com',
      role: Role.tester,
    ),
  ];

  final mockTaskModelist = <TaskModel>[
    TaskModel(
      taskId: 1,
      title: 'Design login screen',
      assignee: mockUserModelList.singleWhere((element) => element.userId == 1),
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.medium,
      status: TaskStatus.todo,
    ),
    TaskModel(
      taskId: 2,
      title: 'Implement API integration',
      priority: TaskPriority.low,
      status: TaskStatus.todo,
    ),
    TaskModel(
      taskId: 3,
      title: 'Fix logout bug',
      description:
          'As soon as user login and tries to logout showing Something went wrong',
      deadline: DateTime.now().add(Duration(days: 1)),
      assignee: mockUserModelList.singleWhere((element) => element.userId == 2),
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
    TaskModel(
      taskId: 4,
      title: 'Update onboarding docs',
      assignee: mockUserModelList.singleWhere((element) => element.userId == 4),
      priority: TaskPriority.low,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    TaskModel(
      taskId: 5,
      title: 'Refactor task bloc logic',
      assignee: mockUserModelList.singleWhere((element) => element.userId == 3),
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.high,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];
