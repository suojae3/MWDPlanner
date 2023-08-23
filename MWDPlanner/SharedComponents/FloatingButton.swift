
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
        return button
    }()

  
    
}
