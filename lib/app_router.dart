import 'package:go_router/go_router.dart';
import 'features/task_board/presentation/pages/task_board_page.dart';
import 'features/task_board/presentation/pages/task_form_page.dart';

final appRouter = GoRouter(
  initialLocation: '/task',
  routes: [
    GoRoute(
      path: '/task',
      name: 'task-board',
      builder: (context, state) => const TaskBoardPage(),
    ),
    GoRoute(
      path: '/task/create',
      name: 'create-task',
      builder: (context, state) => const TaskFormPage(),
    ),
    GoRoute(
      path: '/task/update/:id',
      name: 'update-task',
      builder: (context, state) {
        final taskId = state.pathParameters['id']!;
        return TaskFormPage(taskId: taskId);
      },
    ),
  ],
);
