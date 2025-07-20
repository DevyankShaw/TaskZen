import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taskzen/features/shared/mock/mock_data.dart';
import 'package:taskzen/features/task_board/domain/entities/task.dart';
import 'package:taskzen/features/task_board/presentation/blocs/user/user_bloc.dart';
import 'package:taskzen/features/task_board/presentation/pages/task_form_page.dart';
import 'package:taskzen/features/task_board/presentation/providers/user/user_provider.dart';
import 'package:taskzen/features/task_board/presentation/widgets/task_card.dart';
import 'package:taskzen/router/app_router.dart';
import 'package:taskzen/router/routes.dart';

Future<GoRouter> createRouter(WidgetTester tester, [GoRouter? router]) async {
  await tester.pumpWidget(
    ProviderScope(child: MaterialApp.router(routerConfig: router ?? appRouter)),
  );
  return appRouter;
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home);
  }
}

void main() {
  group(
    'TaskCard - on tap navigation, title, priority, description, assignee, deadline variations',
    () {
      testWidgets('validate on tap navigation', (tester) async {
        final task = mockTaskModelist.first.toEntity();

        final router = GoRouter(
          initialLocation: Routes.task.toPath,
          routes: [
            GoRoute(
              path: Routes.task.toPath,
              name: Routes.task.toName,
              builder: (context, state) => TaskCard(task),
              routes: [
                GoRoute(
                  path: Routes.taskUpdate.toPath,
                  name: Routes.taskUpdate.toName,
                  builder: (context, state) {
                    final task = state.extra as Task?;
                    return ProviderScope(
                      overrides: [
                        userStateProvider.overrideWith(
                          (ref) => Stream.value(UserLoaded(mockUserList)),
                        ),
                      ],
                      child: TaskFormPage(task: task),
                    );
                  },
                ),
              ],
            ),
          ],
        );

        await createRouter(tester, router);

        /// verify TaskCard being displayed
        Finder finder = find.byType(TaskCard);
        expect(finder, findsOneWidget, reason: 'Incorrect widget');

        /// tap action to navigate
        await tester.tap(finder);
        await tester.pumpAndSettle();

        /// verify TaskFormPage being displayed post navigation
        finder = find.byType(TaskFormPage);
        expect(finder, findsOneWidget, reason: 'Incorrect widget');
      });

      testWidgets('validate title', (tester) async {
        final task = mockTaskModelist.first.toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(task)));

        /// verify title display
        final titleFinder = find.text(task.title);
        expect(titleFinder, findsOneWidget, reason: 'Incorrect title');
      });

      testWidgets('validate priority variations', (tester) async {
        final lowPriorityTask = mockTaskModelist[1].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(lowPriorityTask)));

        /// verify priority display
        final priorityFinder = find.text(
          lowPriorityTask.priority.name.toUpperCase(),
        );
        expect(priorityFinder, findsOneWidget, reason: 'Incorrect priority');

        /// verify low priority color
        Container container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(Row),
                matching: find.byType(Container),
              )
              .first,
        );
        BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(
          decoration.color,
          equals(Colors.green.shade200),
          reason: 'Incorrect low priority color',
        );

        final mediumPriorityTask = mockTaskModelist[0].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(mediumPriorityTask)));

        /// verify medium priority color
        container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(Row),
                matching: find.byType(Container),
              )
              .first,
        );
        decoration = container.decoration as BoxDecoration;
        expect(
          decoration.color,
          equals(Colors.orange.shade200),
          reason: 'Incorrect medium priority color',
        );

        final highPriorityTask = mockTaskModelist[2].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(highPriorityTask)));

        /// verify high priority color
        container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(Row),
                matching: find.byType(Container),
              )
              .first,
        );
        decoration = container.decoration as BoxDecoration;
        expect(
          decoration.color,
          equals(Colors.red.shade300),
          reason: 'Incorrect high priority color',
        );
      });

      testWidgets('validate description', (tester) async {
        final taskWithDesc = mockTaskModelist[2].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithDesc)));

        /// verify description display
        Finder descFinder = find.text(taskWithDesc.description ?? '');
        expect(descFinder, findsOneWidget, reason: 'Incorrect description');

        final taskWithoutDesc = mockTaskModelist[0].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithoutDesc)));

        /// verify description not display
        descFinder = find.text(taskWithoutDesc.description ?? '');
        expect(descFinder, findsNothing, reason: 'Incorrect description');
      });

      testWidgets('validate assignee', (tester) async {
        final taskWithAssignee = mockTaskModelist[3].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithAssignee)));

        /// verify assignee display
        Finder assigneeFinder = find.byIcon(Icons.assignment_ind_outlined);
        expect(
          assigneeFinder,
          findsOneWidget,
          reason: 'Incorrect assignee placeholder widget',
        );

        assigneeFinder = find.text(taskWithAssignee.assignee!.name);
        expect(
          assigneeFinder,
          findsOneWidget,
          reason: 'Incorrect assignee name',
        );

        final taskWithoutAssignee = mockTaskModelist[1].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithoutAssignee)));

        /// verify assignee not display
        assigneeFinder = find.byIcon(Icons.assignment_ind_outlined);
        expect(assigneeFinder, findsNothing, reason: 'Incorrect assignee name');
      });

      testWidgets('validate deadline', (tester) async {
        final taskWithDeadline = mockTaskModelist[0].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithDeadline)));

        /// verify deadline display
        Finder deadlineFinder = find.byIcon(Icons.access_time_outlined);
        expect(
          deadlineFinder,
          findsOneWidget,
          reason: 'Incorrect deadline placeholder widget',
        );

        deadlineFinder = find.text(
          DateFormat('d MMM, h:mm a').format(taskWithDeadline.deadline!),
        );
        expect(deadlineFinder, findsOneWidget, reason: 'Incorrect deadline');

        final taskWithoutDeadline = mockTaskModelist[1].toEntity();
        await tester.pumpWidget(MyWidget(home: TaskCard(taskWithoutDeadline)));

        /// verify deadline not display
        deadlineFinder = find.byIcon(Icons.access_time_outlined);
        expect(deadlineFinder, findsNothing, reason: 'Incorrect deadline');
      });
    },
  );
}
