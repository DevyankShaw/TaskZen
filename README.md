# TaskZen

A collaborative task management app where users can create, assign, and manage tasks across different stages (To Do, In Progress, Done). 


# Challenge Approach (Daywise)

 Day 1 | 28/6/25 | 4 Hr
   - List down the task and its subtasks to get started with the challenge, like a high-level breakdown of features, entities, etc
   - Learned the riverpod with integration steps and thinking of how to bind Bloc (Business Logic) with Riverpod (UI States) 
   - Revisited clean architecture and defined the folder structure following its principles. 

Day 2 | 29/6/25 | 11 Hr
   - Started with the implementation of the task board page UI, following up with entities, repositories, use cases, local storage (mock data), and finally binding Bloc with Riverpod
   - Understand the importance of [Either](https://codewithandrea.com/articles/functional-error-handling-either-fpdart/), which makes it easy and enforceable for error handling at compile time
   - Applied the same strategy to implement the task form page to create/update a task

Day 3 | 1/7/25 | 5 Hr
   - Implementing search and filter functionality is a bit of decision-making, especially keeping track of searched/filtered keywords, whether using Bloc or Riverpod. But finally, make it using Riverpod, which was even testable
   - Setting up Bloc Observer was helpful in debugging, as it showed what event and its input are being executed

