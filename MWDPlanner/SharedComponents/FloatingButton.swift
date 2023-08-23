
import UIKit




//MARK: Instantiation
class FloatingButton {
    


    let tasksTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapAddTask), for: .touchUpInside)
        return button
    }()
}

//밖의 뷰컨트롤러가 필요한 상황
extension FloatingButton {
    @objc func didTapAddTask() {
           let addTaskSheet = AddTaskActionSheet()
            present(addTaskSheet, animated: true)
        }
}
