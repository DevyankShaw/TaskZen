import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/enum/enum.dart';
import '../../../domain/entities/user.dart';
import 'filter_state.dart';

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(const FilterState());

  void setTitle(String? title) {
    state = state.copyWith(searchedTitle: title);
  }

  void setAssignees(List<User> users) {
    state = state.copyWith(selectedAssignees: users);
  }

  void setPriorities(List<TaskPriority> priorities) {
    state = state.copyWith(selectedPriorities: priorities);
  }

  void clearFilters() {
    state = const FilterState();
  }
}

final filterStateProvider = StateNotifierProvider<FilterNotifier, FilterState>((
  ref,
) {
  return FilterNotifier();
});
