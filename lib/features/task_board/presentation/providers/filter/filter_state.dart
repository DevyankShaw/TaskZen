import 'package:equatable/equatable.dart';
import '../../../../shared/enum/enum.dart';
import '../../../domain/entities/user.dart';

class FilterState extends Equatable {
  final String? searchedTitle;
  final List<User> selectedAssignees;
  final List<TaskPriority> selectedPriorities;

  const FilterState({
    this.searchedTitle,
    this.selectedAssignees = const [],
    this.selectedPriorities = const [],
  });

  FilterState copyWith({
    String? searchedTitle,
    List<User>? selectedAssignees,
    List<TaskPriority>? selectedPriorities,
  }) {
    return FilterState(
      searchedTitle: searchedTitle ?? this.searchedTitle,
      selectedAssignees: selectedAssignees ?? this.selectedAssignees,
      selectedPriorities: selectedPriorities ?? this.selectedPriorities,
    );
  }

  @override
  List<Object?> get props => [searchedTitle, selectedAssignees, selectedPriorities];
}
