import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskzen/features/task_board/domain/entities/user.dart';

import '../../../shared/enum/enum.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../providers/filter/filter_provider.dart';
import '../providers/task/task_provider.dart';
import '../providers/user/user_provider.dart';
import 'filter_field.dart';

class FilterContent extends ConsumerWidget {
  const FilterContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterStateProvider);
    final filterNotifier = ref.read(filterStateProvider.notifier);

    final searchedTitle = filterState.searchedTitle;
    final selectedTaskPriorities = filterState.selectedPriorities;
    final selectedAssignees = filterState.selectedAssignees;

    final state = ref.watch(userStateProvider);

    return state.when(
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
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterField(
                          label: 'Assignee',
                          values: userState.users.map((User user) {
                            final isSelected = selectedAssignees.contains(user);
                            return FilterChip(
                              selected: isSelected,
                              label: Text(user.name),
                              shape: const StadiumBorder(side: BorderSide()),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onSelected: (bool selected) {
                                final updatedList = [...selectedAssignees];
                                if (selected) {
                                  updatedList.add(user);
                                } else {
                                  updatedList.remove(user);
                                }
                                filterNotifier.setAssignees(updatedList);
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24),
                        FilterField(
                          label: 'Priority',
                          values: TaskPriority.values.map((
                            TaskPriority taskPriority,
                          ) {
                            final isSelected = selectedTaskPriorities.contains(
                              taskPriority,
                            );
                            return FilterChip(
                              selected: isSelected,
                              label: Text(taskPriority.realName),
                              shape: const StadiumBorder(side: BorderSide()),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onSelected: (bool selected) {
                                final updated = [...selectedTaskPriorities];
                                if (selected) {
                                  updated.add(taskPriority);
                                } else {
                                  updated.remove(taskPriority);
                                }
                                filterNotifier.setPriorities(updated);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          // TODO: Need to reset controller while trying to clear using clear button on bottom sheet
                          filterNotifier.clearFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if ((searchedTitle?.isEmpty ?? true) &&
                              selectedAssignees.isEmpty &&
                              selectedTaskPriorities.isEmpty) {
                            ref.read(taskBlocProvider).add(LoadTasksEvent());
                          } else {
                            ref
                                .read(taskBlocProvider)
                                .add(
                                  FilterTasksEvent(
                                    title: searchedTitle,
                                    assignees: selectedAssignees,
                                    priorities: selectedTaskPriorities,
                                  ),
                                );
                          }

                          context.pop();
                        },
                        icon: const Icon(Icons.content_paste_search_outlined),
                        label: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
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

        return SizedBox.shrink();
      },
    );
  }
}
