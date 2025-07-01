import 'package:flutter/material.dart';

import '../../../shared/enum/enum.dart';
import '../../domain/entities/task.dart';
import 'task_card.dart';

class GroupTaskLayout extends StatelessWidget {
  final List<Task> tasks;
  const GroupTaskLayout({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final groupedTasks = _groupTasksByStatus(tasks);
    final isGroupTaskEmpty = groupedTasks.values.every(
      (element) => element.isEmpty,
    );
    return Expanded(
      child: !isGroupTaskEmpty
          ? ListView.builder(
              itemCount: groupedTasks.length,
              itemBuilder: (context, index) {
                final status = groupedTasks.keys.elementAt(index);
                final taskList = groupedTasks[status]!;

                if (taskList.isNotEmpty) {
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
                              status.realName.toUpperCase(),
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
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          : Center(
              child: Text(
                'No Tasks Found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
