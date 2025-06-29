enum TaskStatus {
  todo('Todo'),
  inProgress('In Progress'),
  done('Done');

  const TaskStatus(this.realName);
  final String realName;
}

enum TaskPriority {
  low('Low'),
  medium('Medium'),
  high('High');

  const TaskPriority(this.realName);
  final String realName;
}

enum Role {
  productOwner('Product Owner'),
  designer('Designer'),
  developer('Developer'),
  tester('Tester');

  const Role(this.realName);
  final String realName;
}
