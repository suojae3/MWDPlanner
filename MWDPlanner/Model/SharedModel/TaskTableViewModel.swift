
import Foundation



class TaskTableViewModel {
    
    
    private let taskService = TaskService()
    private var tasks: [Task] = []
    
    func fetchTasks() {
        tasks = taskService.fetchTasks()
    }
    
    func taskCount() -> Int {
        self.fetchTasks()
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        self.fetchTasks()
        return tasks[index]
    }
}


