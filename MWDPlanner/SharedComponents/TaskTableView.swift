import UIKit


// UITableView의 display와 manage를 책임지는 클래스
class TaskTableView: NSObject {
    
    var taskTableViewModel: TaskTableViewModel
    var addTaskSheetMdoel: AddTaskSheetModel

    
    // task를 나타낼 테이블 뷰 정의하기
    let tasksTableView: UITableView = {
        let tableView = UITableView()
        
        //테이블 뷰의 기본 셀 등록하기
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return tableView
    }()
    
    // 데이터 source와 delegate 생성하기
    init(taskTableViewModel: TaskTableViewModel, addTaskSheetModel: AddTaskSheetModel) {
         self.taskTableViewModel = taskTableViewModel
         self.addTaskSheetMdoel = addTaskSheetModel
         
         
         super.init()
         tasksTableView.dataSource = self
         tasksTableView.delegate = self
         
         addTaskSheetMdoel.createTaskDelegate = self
     }
}



extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
    
    // task 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTableViewModel.taskCount()

    }
    
    // task 보여주는 cell 구현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = taskTableViewModel.task(at: indexPath.row)
        cell.textLabel?.text = task.title
        return cell
        
    }
}


extension TaskTableView: CreateTaskDelegate {
    func createTask() {
        let newRow = taskTableViewModel.taskCount() - 1
        let newIndexPath = IndexPath(row: newRow, section: 0)
        self.tasksTableView.insertRows(at: [newIndexPath], with: .fade)
    }
}

