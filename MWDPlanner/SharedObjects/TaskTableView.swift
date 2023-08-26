import UIKit

class TaskTableView: NSObject {
    
    private var tasks: [Task] = []
    private let taskService: TaskService
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return tableView
    }()

     init(service: TaskService) {
        self.taskService = service
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
         
        // 클로저를 통해 모델과 연결
        self.taskService.fetchCompletion = { [weak self] taskArray in
            self?.tasks = taskArray
        }
        tasks = taskService.fetchActiveTasks()
    }
}
extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "해야할 일" : "완수한 일"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? taskService.fetchActiveTasks().count : taskService.fetchDeletedTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task: Task
        if indexPath.section == 0 {
            task = taskService.fetchActiveTasks()[indexPath.row]
        } else {
            task = taskService.fetchDeletedTasks()[indexPath.row]
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:00"
        let formattedDate = dateFormatter.string(from: task.dueDate)
        cell.textLabel?.text = "[\(formattedDate)] \(task.title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            
            switch indexPath.section {
                
            // 해야할 일
            case 0:
                let taskToDelete = self.taskService.fetchActiveTasks()[indexPath.row]
                self.taskService.delete(taskToDelete)
            
            // 끝낸 일
            case 1:
                let taskToPermanentlyDelete = self.taskService.fetchDeletedTasks()[indexPath.row]
                self.taskService.permanentlyDelete(taskToPermanentlyDelete)
                
            default:
                break
            }
            
            tableView.reloadData()
            completion(true)
        }
        
        action.backgroundColor = .black
        action.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }

}
