import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../blocs/task/task_bloc.dart';
import '../providers/task/task_provider.dart';
import '../widgets/group_task_layout.dart';
import '../widgets/search_field.dart';

class TaskBoardPage extends ConsumerWidget {
  const TaskBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskStateProvider);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontSize: 18),
        title: const Text('Task Board'),
        bottom: SearchField(),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            err.toString(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        data: (taskState) {
          switch (taskState) {
            case TaskLoading():
              return const Center(child: CircularProgressIndicator());
            case TaskLoaded():
              return GroupTaskLayout(tasks: taskState.tasks);
            case TaskError():
              return Center(
                child: Text(
                  taskState.message,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        onPressed: () {
          context.goNamed(Routes.taskCreate.toName);
        },
        child: const Icon(Icons.add_circle_outline_outlined, size: 28),
      ),
    );
  }
}
