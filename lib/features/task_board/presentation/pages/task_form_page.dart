import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../shared/enum/enum.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/user.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../providers/task/task_provider.dart';
import '../providers/user/user_provider.dart';

class TaskFormPage extends ConsumerStatefulWidget {
  final Task? task;
  const TaskFormPage({super.key, this.task});

  @override
  ConsumerState<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends ConsumerState<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _deadlineController;

  TaskPriority _priority = TaskPriority.low;
  TaskStatus _status = TaskStatus.todo;
  DateTime? _deadline;
  User? _assignee;

  final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _deadlineController = TextEditingController();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _deadlineController.text = widget.task!.deadline != null
          ? dateFormat.format(widget.task!.deadline!)
          : '';
      _deadline = widget.task!.deadline;
      _assignee = widget.task!.assignee;
      _priority = widget.task!.priority;
      _status = widget.task!.status;
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();

    final bloc = ref.read(taskBlocProvider);
    if (widget.task == null) {
      final task = Task(
        id: now.millisecondsSinceEpoch,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        assignee: _assignee,
        deadline: _deadline,
        priority: _priority,
        status: _status,
        createdAt: now,
      );
      bloc.add(AddTaskEvent(task));
    } else {
      final task = widget.task!.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        assignee: _assignee,
        deadline: _deadline,
        priority: _priority,
        status: _status,
        updatedAt: now,
      );
      bloc.add(UpdateTaskEvent(task));
    }
    //TODO: Need to find way to rebuild with filtered values or reset it post add/update task

    context.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    _assignee = null;
    _deadline = null;
    _priority = TaskPriority.low;
    _status = TaskStatus.todo;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userStateProvider);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontSize: 18),

        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task != null ? 'Update Task' : 'Create Task'),
            if (widget.task != null)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  DateFormat(
                    'dd MMMM, yyyy hh:mm a',
                  ).format(widget.task!.updatedAt ?? widget.task!.createdAt),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                ),
              ),
          ],
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            err.toString(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        data: (userState) {
          switch (userState) {
            case UserLoading():
              return const Center(child: CircularProgressIndicator());
            case UserLoaded():
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.titleMedium,
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (val) => val!.isEmpty ? 'Enter title' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        maxLines: 3,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<User>(
                        value: _assignee,
                        items: userState.users
                            .map(
                              (m) => DropdownMenuItem(
                                value: m,
                                child: Text('${m.name} (${m.role.realName})'),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => _assignee = val,
                        decoration: const InputDecoration(
                          labelText: 'Assignee',
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _deadlineController,
                        readOnly: true,
                        onTap: () async {
                          _deadline = await _showDateTimePicker(
                            _deadline ?? DateTime.now(),
                          );

                          if (_deadline != null) {
                            _deadlineController.text = dateFormat.format(
                              _deadline!,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Deadline',
                          hintText: 'Select Deadline',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<TaskPriority>(
                        value: _priority,
                        items: TaskPriority.values
                            .map(
                              (p) => DropdownMenuItem(
                                value: p,
                                child: Text(p.realName),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => _priority = val!,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<TaskStatus>(
                        value: _status,
                        items: TaskStatus.values
                            .map(
                              (s) => DropdownMenuItem(
                                value: s,
                                child: Text(s.realName),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => _status = val!,
                        decoration: const InputDecoration(labelText: 'Status'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => _submit(),
                        child: Text(widget.task != null ? 'Update' : 'Create'),
                      ),
                    ],
                  ),
                ),
              );
            case UserError():
              return Center(
                child: Text(
                  userState.message,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
          }
          return null;
        },
      ),
    );
  }

  Future<DateTime?> _showDateTimePicker([DateTime? initialDateTime]) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final selectedTime = await showTimePicker(
      context: context.mounted ? context : context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime ?? selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}
