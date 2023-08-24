
import Foundation



class TaskTableViewModel {
    private var tasks: [Task] = []
    
    private let taskService: TaskService
    
    init(service: TaskService) {
        self.taskService = service
        tasks = taskService.fetchTasks()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
}
