
import Foundation


class TaskTableViewModel {
    

    private let taskService = TaskService()
    private var tasks: [Task] = []
    
    func fetchTasks() {
        tasks = taskService.fetchTasks()
    }
    
    func taskCount() -> Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
}


