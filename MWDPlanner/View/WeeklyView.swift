
import UIKit
import FSCalendar

//MARK: Instantiation
class WeeklyView: UIViewController {
    
    
    private lazy var taskService = TaskService.shared
    private let searchBar = SearchBarController()
    private lazy var taskTableView = TableViewController(service: taskService, searchBar: searchBar)
    private let floatingButton = FloatingButtonController()

    

    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Inter-Medium", size: 24)
        return title
    }()
    
    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    private let dateLabel: UILabel = {
        let date = UILabel()
        date.text = "date"
        date.font = UIFont(name: "Inter-SemiBold", size: 20)
        return date
    }()
}

//MARK: LifeCycle
extension WeeklyView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingButton.delegate = self
        calendarView.scope = .week
        calendarView.delegate = self
        calendarView.dataSource = self
        setupUI()
        
        QuoteService.shared.fetchRandomQuote { [weak self] quote in
            DispatchQueue.main.async {
                self?.titleLabel.text = quote
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTableView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        QuoteService.shared.fetchRandomQuote { [weak self] quote in
            DispatchQueue.main.async {
                self?.titleLabel.text = quote
            }
        }

    }

    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, calendarView, dateLabel, taskTableView.tableView, floatingButton.floatingButton].forEach { view.addSubview($0) }
        
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
            size: .init(width: 40, height: 90)
        )
        
        calendarView.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
            size: CGSize(width: 0, height: 250)

        )
        
        dateLabel.anchor(
            top: calendarView.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 100, left: 20, bottom: 0, right: 20)
        )
        
        taskTableView.tableView.anchor (
            top: dateLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: CGSize(width: 100, height: 500)
        )
        
        floatingButton.floatingButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 20),
            size: .init(width: 50, height: 50)
        )
        
        print(taskTableView.tableView.frame)

    
    
    }
}


extension WeeklyView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame.size = bounds.size
        
        // You might want to adjust any other UI elements that depend on the calendar's size here.
        // For example, if other views are positioned relative to the calendar's bottom,
        // you might need to update their positions.
    }
}


// MARK: - FloatingButton Delegate

extension WeeklyView: FloatingButtonDelegate {
    func showAddTaskActionSheet() {
        let addTaskSheet = AddTaskActionSheetController(taskService: taskService) { [weak self] in
            guard let self = self else { return }
            self.taskTableView.tasks = self.taskService.fetchActiveTasks()
            self.taskTableView.tableView.reloadData()
        }
        present(addTaskSheet, animated: true, completion: nil)
    }
}


