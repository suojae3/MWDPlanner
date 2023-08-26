import Foundation

class TaskService {

    private let tasksKey = "tasks"
    static let shared = TaskService()
    var fetchCompletion: (([Task]) -> Void)?

    private init() {}
    
    private func saveTasksToUserDefaults(_ tasks: [Task]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
            self.fetchCompletion?(tasks)
        }
    }

    func fetchTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return [] }
        return tasks
    }
    
    func save(_ task: Task) {
        var tasks = fetchTasks()
        tasks.insert(task, at: 0)
        saveTasksToUserDefaults(tasks)
    }
    
    func delete(_ task: Task) {
        var tasks = fetchTasks()
        tasks.removeAll { $0 == task }
        saveTasksToUserDefaults(tasks)
    }


}
