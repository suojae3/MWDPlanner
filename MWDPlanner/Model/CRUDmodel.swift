


import Foundation

class TaskService {

    private let activeTasksKey = "activeTasks"
    private let deletedTasksKey = "deletedTasks"
    
    static let shared = TaskService()
    var fetchCompletion: (([Task]) -> Void)?

    private init() {}
    
    private func saveTasksToUserDefaults(tasks: [Task], forKey key: String) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: key)
            self.fetchCompletion?(tasks)
        }
    }

    func fetchActiveTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: activeTasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return [] }
        return tasks
    }

    func fetchDeletedTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: deletedTasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return [] }
        return tasks
    }

    func save(_ task: Task) {
        var tasks = fetchActiveTasks()
        tasks.insert(task, at: 0)
        saveTasksToUserDefaults(tasks: tasks, forKey: activeTasksKey)
    }
    
    func delete(_ task: Task) {
        var activeTasks = fetchActiveTasks()
        var deletedTasks = fetchDeletedTasks()
        
        if let index = activeTasks.firstIndex(of: task) {
            activeTasks.remove(at: index)
            deletedTasks.append(task)
            
            saveTasksToUserDefaults(tasks: activeTasks, forKey: activeTasksKey)
            saveTasksToUserDefaults(tasks: deletedTasks, forKey: deletedTasksKey)
        }
    }
    
    func permanentlyDelete(_ task: Task) {
        var deletedTasks = fetchDeletedTasks()
        
        if let index = deletedTasks.firstIndex(of: task) {
            deletedTasks.remove(at: index)
            saveTasksToUserDefaults(tasks: deletedTasks, forKey: deletedTasksKey)
        }
    }

}


