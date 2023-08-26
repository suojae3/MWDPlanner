//
//import Foundation
//
//
//
//class TaskTableViewModel {
//
//    private var tasks: [Task] = []
//
//    private let taskService: TaskService
//
//    init(service: TaskService) {
//        self.taskService = service
//        self.taskService.fetchCompletion = { [weak self] taskArray in
//            self?.tasks = taskArray
//        }
//        tasks = taskService.fetchTasks()
//    }
//
//    var numberOfTasks: Int {
//        tasks.count
//    }
//
//    func task(at index: Int) -> Task {
//        return tasks[index]
//    }
//}
