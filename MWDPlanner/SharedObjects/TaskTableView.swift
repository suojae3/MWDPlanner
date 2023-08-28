//import UIKit
//
//class TaskTableView: NSObject {
//
//    var tasks: [Task] = []
//    var filteredData: [Task] = []
//    var filteredDeletedTasks: [Task] = []
//
//    private let taskService: TaskService
//    private let searchBar: SearchBarController
//
//
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
//        return tableView
//    }()
//
//    init(service: TaskService, searchBar: SearchBarController) {
//         self.taskService = service
//         self.searchBar = searchBar
//
//        super.init()
//        tableView.dataSource = self
//        tableView.delegate = self
//        searchBar.delegate = self
//
//        self.taskService.fetchCompletion = { [weak self] taskArray in
//            self?.tasks = taskArray
//        }
//        tasks = taskService.fetchActiveTasks()
//    }
//}
//
//
//
//extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section == 0 ? "해야할 일" : "완수한 일"
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchBar.searchBar.isFirstResponder, !searchBar.searchBar.text!.isEmpty {
//            if section == 0 {
//                return filteredData.count
//            } else {
//                return filteredDeletedTasks.count
//            }
//        } else {
//            if section == 0 {
//                return taskService.fetchActiveTasks().count
//            } else {
//                return taskService.fetchDeletedTasks().count
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
//        let task: Task
//
//        if searchBar.searchBar.isFirstResponder, !searchBar.searchBar.text!.isEmpty {
//            if indexPath.section == 0 {
//                task = filteredData[indexPath.row]
//            } else {
//                task = filteredDeletedTasks[indexPath.row]
//            }
//        } else {
//            if indexPath.section == 0 {
//                task = taskService.fetchActiveTasks()[indexPath.row]
//            } else {
//                task = taskService.fetchDeletedTasks()[indexPath.row]
//            }
//        }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd HH:mm"
//        let formattedDate = dateFormatter.string(from: task.dueDate)
//        cell.textLabel?.text = "[\(formattedDate)] \(task.title)"
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
//
//            switch indexPath.section {
//                 case 0:
//                     let taskToDelete: Task
//                     if self.searchBar.searchBar.isFirstResponder, !self.searchBar.searchBar.text!.isEmpty {
//                         taskToDelete = self.filteredData[indexPath.row]
//                     } else {
//                         taskToDelete = self.taskService.fetchActiveTasks()[indexPath.row]
//                     }
//                     self.taskService.delete(taskToDelete)
//                 case 1:
//                     let taskToPermanentlyDelete: Task
//                     if self.searchBar.searchBar.isFirstResponder, !self.searchBar.searchBar.text!.isEmpty {
//                         taskToPermanentlyDelete = self.filteredDeletedTasks[indexPath.row]
//                     } else {
//                         taskToPermanentlyDelete = self.taskService.fetchDeletedTasks()[indexPath.row]
//                     }
//                     self.taskService.permanentlyDelete(taskToPermanentlyDelete)
//                 default:
//                     break
//                 }
//            tableView.reloadData()
//            completion(true)
//        }
//
//        action.backgroundColor = .black
//        action.image = UIImage(systemName: "trash")
//
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        configuration.performsFirstActionWithFullSwipe = true
//
//        return configuration
//    }
//}
//
//
//extension TaskTableView: SearchBarDelegate {
//
//    func searchFilter(with searchText: String) {
//        filteredData = taskService.fetchActiveTasks().filter { task in
//            return task.title.lowercased().contains(searchText.lowercased())
//        }
//        filteredDeletedTasks = taskService.fetchDeletedTasks().filter { task in
//            return task.title.lowercased().contains(searchText.lowercased())
//        }
//        print("서치 델리게이트 작동하는지 테스트")
//        tableView.reloadData()
//
//    }
//}
import UIKit

class TaskTableView: NSObject {
    
    // MARK: 인스턴스
    
    var tasks: [Task] = []
    var filteredData: [Task] = []
    var filteredDeletedTasks: [Task] = []

    private let taskService: TaskService
    private let searchBar: SearchBarController
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return tableView
    }()
    
    // MARK: 초기화
    
    init(service: TaskService, searchBar: SearchBarController) {
        self.taskService = service
        self.searchBar = searchBar
         
        super.init()
        setupTableView()
        setupSearchBar()
        loadTasks()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func loadTasks() {
        self.taskService.fetchCompletion = { [weak self] taskArray in
            self?.tasks = taskArray
        }
        tasks = taskService.fetchActiveTasks()
    }
}


// MARK: UITableViewDataSource, UITableViewDelegate

extension TaskTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "해야할 일" : "완수한 일"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isInSearchMode = searchBar.searchBar.isFirstResponder && !searchBar.searchBar.text!.isEmpty
        
        if section == 0 {
            return isInSearchMode ? filteredData.count : taskService.fetchActiveTasks().count
        } else {
            return isInSearchMode ? filteredDeletedTasks.count : taskService.fetchDeletedTasks().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task = getTask(for: indexPath)
        configureCell(cell, with: task)
        
        return cell
    }
    
    private func getTask(for indexPath: IndexPath) -> Task {
        let isInSearchMode = searchBar.searchBar.isFirstResponder && !searchBar.searchBar.text!.isEmpty
        
        if indexPath.section == 0 {
            return isInSearchMode ? filteredData[indexPath.row] : taskService.fetchActiveTasks()[indexPath.row]
        } else {
            return isInSearchMode ? filteredDeletedTasks[indexPath.row] : taskService.fetchDeletedTasks()[indexPath.row]
        }
    }
    
    private func configureCell(_ cell: UITableViewCell, with task: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        let formattedDate = dateFormatter.string(from: task.dueDate)
        cell.textLabel?.text = "[\(formattedDate)] \(task.title)"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
            self.handleSwipeAction(for: indexPath)
            tableView.reloadData()
            completion(true)
        }
        
        action.backgroundColor = .black
        action.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func handleSwipeAction(for indexPath: IndexPath) {
        let task = getTask(for: indexPath)
        switch indexPath.section {
        case 0:
            taskService.delete(task)
        case 1:
            taskService.permanentlyDelete(task)
        default:
            break
        }
    }
}

// MARK: SearchBarDelegate

extension TaskTableView: SearchBarDelegate {
    func searchFilter(with searchText: String) {
        filteredData = taskService.fetchActiveTasks().filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        
        filteredDeletedTasks = taskService.fetchDeletedTasks().filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
