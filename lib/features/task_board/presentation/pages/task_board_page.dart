import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskzen/features/task_board/presentation/blocs/task/task_bloc.dart';

import '../../domain/entities/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';

class TaskBoardPage extends ConsumerWidget {
  const TaskBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Board')),
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
              final groupedTasks = _groupTasksByStatus(taskState.tasks);
              return ListView.builder(
                itemCount: groupedTasks.length,
                itemBuilder: (context, index) {
                  final status = groupedTasks.keys.elementAt(index);
                  final taskList = groupedTasks[status]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              status.name.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(width: 8),
                            Badge.count(
                              count: taskList.length,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      ...taskList.map((task) => TaskCard(task)),
                    ],
                  );
                },
              );
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
    );
  }

  Map<TaskStatus, List<Task>> _groupTasksByStatus(List<Task> tasks) {
    final map = <TaskStatus, List<Task>>{};
    for (var status in TaskStatus.values) {
      map[status] = tasks.where((t) => t.status == status).toList();
    }
    return map;
  }
}
