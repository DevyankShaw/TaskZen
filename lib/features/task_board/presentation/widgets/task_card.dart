import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../shared/enum/enum.dart';
import '../../domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard(this.task, {super.key});

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green.shade200;
      case TaskPriority.medium:
        return Colors.orange.shade200;
      case TaskPriority.high:
        return Colors.red.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: () => context.go('/task/update', extra: task),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.title),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _priorityColor(task.priority),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.priority.name.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description != null)
                Text(task.description!, style: TextStyle(fontSize: 12)),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (task.assigneeId != null)
                      Expanded(
                        child: IconLabelValue(
                          icon: Icons.assignment_ind_outlined,
                          label: 'Assigned To',
                          value: _getAssigneeName(task.assigneeId!),
                        ),
                      ),
                    if (task.deadline != null)
                      Expanded(
                        child: IconLabelValue(
                          icon: Icons.access_time_outlined,
                          label: 'Deadline',
                          value: DateFormat(
                            _getCustomDateFormat(task.deadline!),
                          ).format(task.deadline!),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Replace with local storage response
  String _getAssigneeName(int id) {
    final team = {1: "Alice", 2: "Bob", 3: "Charlie", 4: "Diana", 5: "Rahul"};
    return team[id] ?? "Unassigned";
  }

  String _getCustomDateFormat(DateTime deadline) {
    if (DateUtils.isSameDay(deadline, DateTime.now())) {
      return 'hh:mm a';
    } else if (deadline.year == DateTime.now().year) {
      return 'd MMM, h:mm a';
    } else {
      return 'd MMM yyyy';
    }
  }
}

class IconLabelValue extends StatelessWidget {
  const IconLabelValue({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon), SizedBox(width: 4), Text(value)],
      ),
    );
  }
}
