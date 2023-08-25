import UIKit


// UITableView의 display와 manage를 책임지는 클래스
class TaskTableView: NSObject {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return tableView
    }()
    
    let taskTableViewModel: TaskTableViewModel
    
    init(taskTableViewModel: TaskTableViewModel) {
        self.taskTableViewModel = taskTableViewModel
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        taskTableViewModel.numberOfTasks
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = taskTableViewModel.task(at: indexPath.row)
        print(task.title)
        cell.textLabel?.text = task.title
        return cell
    }
}
