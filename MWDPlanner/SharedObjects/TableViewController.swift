
import UIKit

class TableViewController: NSObject {
    
    // MARK: - 인스턴스 셋팅
    
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
    
    // MARK: - 초기화 셋팅
    
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


// MARK: - UITableViewDataSource, UITableViewDelegate

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
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

// MARK: - SearchBarDelegate

extension TableViewController: SearchBarDelegate {
    func searchFilter(with searchText: String) {
        filteredData = taskService.fetchActiveTasks().filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        
        filteredDeletedTasks = taskService.fetchDeletedTasks().filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        print("서치 델리게이트 작동하는지 테스트")
        tableView.reloadData()
    }
}
