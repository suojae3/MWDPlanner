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
        tasks = taskService.fetchTasks()
    }
}


extension TaskTableView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            
            // userDefaults 데이터 삭제
            self.taskService.delete(self.tasks[indexPath.row])
            
            // table view row 삭제
            tableView.deleteRows(at: [indexPath], with: .left)
            completion(true)
        }
        
        action.backgroundColor = .black
        action.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH:00"
        let formattedDate = dateFormatter.string(from: task.dueDate)
        cell.textLabel?.text = "[\(formattedDate)] \(task.title)"
        return cell
    }
}
