import UIKit


// UITableView의 display와 manage를 책임지는 클래스
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
         
         // 클로저를 통해 모델과 연결
         self.taskService.fetchCompletion = { [weak self] taskArray in
             self?.tasks = taskArray
         }
         tasks = taskService.fetchTasks()

        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
      
        let task = tasks[indexPath.row]
        print(task)
        cell.textLabel?.text = task.title
        return cell
    }
}
