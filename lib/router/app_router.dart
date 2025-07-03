import 'package:go_router/go_router.dart';
import '../features/task_board/domain/entities/task.dart';
import '../features/task_board/presentation/pages/task_board_page.dart';
import '../features/task_board/presentation/pages/task_form_page.dart';
import 'routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.task.toPath,
  routes: [
    GoRoute(
      path: Routes.task.toPath,
      name: Routes.task.toName,
      builder: (context, state) => const TaskBoardPage(),
      routes: [
        GoRoute(
          path: Routes.taskCreate.toPath,
          name: Routes.taskCreate.toName,
          builder: (context, state) => const TaskFormPage(),
        ),
        GoRoute(
          path: Routes.taskUpdate.toPath,
          name: Routes.taskUpdate.toName,
          builder: (context, state) {
            final task = state.extra as Task?;
            return TaskFormPage(task: task);
          },
        ),
      ],
    ),
  ],
);
