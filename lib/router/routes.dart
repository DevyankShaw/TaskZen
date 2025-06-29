enum Routes { task, taskCreate, taskUpdate }

extension RouteExtension on Routes {
  String get toPath {
    switch (this) {
      case Routes.task:
        return "/task";
      case Routes.taskCreate:
        return "/create";
      case Routes.taskUpdate:
        return "/update";
    }
  }

  String get toName {
    switch (this) {
      case Routes.task:
        return "task";
      case Routes.taskCreate:
        return "task-create";
      case Routes.taskUpdate:
        return "task-update";
    }
  }
}
