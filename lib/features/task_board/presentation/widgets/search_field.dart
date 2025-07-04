import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/theme/app_theme.dart';
import '../blocs/task/task_bloc.dart';
import '../providers/filter/filter_provider.dart';
import '../providers/task/task_provider.dart';
import 'filter_content.dart';

class SearchField extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppTheme.backgroundColor,
      child: TextField(
        controller: _controller,
        onChanged: (taskName) {
          final filterNotifier = ref.read(filterStateProvider.notifier);
          filterNotifier.setTitle(taskName.trim());

          final filterState = ref.read(filterStateProvider);
          final searchedTitle = filterState.searchedTitle;
          final selectedTaskPriorities = filterState.selectedPriorities;
          final selectedAssignees = filterState.selectedAssignees;

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
        },
        decoration: InputDecoration(
          hintText: 'Search by title ',
          prefixIcon: const Icon(Icons.search_outlined),
          suffixIcon: IconButton(
            tooltip: 'Filter',
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }

  _showFilterBottomSheet() {
    final textTheme = Theme.of(context).textTheme;
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8),
          right: Radius.circular(8),
        ),
      ),
      constraints: const BoxConstraints.tightFor(height: 380),
      builder: (_) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Filter',
                    style: textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close_outlined),
                ),
              ],
            ),
            const Divider(color: Colors.blueGrey, height: 2, thickness: 0.5),
            Expanded(child: FilterContent()),
          ],
        );
      },
    );
  }
}
