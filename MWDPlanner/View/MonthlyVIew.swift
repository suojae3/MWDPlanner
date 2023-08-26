//
//  ViewController.swift
//  MyPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit
import FSCalendar


// UIComponent랑 변수명 맞추기

//MARK: Instantiation
class MonthlyView: UIViewController {
    
    private lazy var taskService = TaskService.shared
    private lazy var taskTableView = TaskTableView(service: taskService)
    private let floatingButton = FloatingButton()

    private let profileView: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           return view
       }()
    
    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    private let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
            searchBar.placeholder = "할 일을 검색해보세요"
            searchBar.searchTextField.backgroundColor = UIColor.clear

           return searchBar
       }()
    
    //플로팅 버튼 화면전환
    weak var floatingButtonDelegate: FloatingButtonDelegate?
        

}

//MARK: LifeCycle
extension MonthlyView {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        taskTableView.tableView.reloadData()
        floatingButton.delegate = self
        calendarView.delegate = self
        calendarView.dataSource = self
        searchBar.delegate = self

    }
}

//MARK: 서치바 델리게이트
extension MonthlyView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            taskTableView.tasks = taskService.fetchActiveTasks()
        } else {
            taskTableView.tasks = taskService.fetchActiveTasks().filter { task in
                return task.title.lowercased().contains(searchText.lowercased())
            }
        }
        taskTableView.tableView.reloadData()
    }
}


//MARK: 캘린더 델리게이트 및 소스
extension MonthlyView: FSCalendarDelegate, FSCalendarDataSource {
    // Implement delegate and data source methods here
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Handle the logic when a date is selected
        
    }
    
    // Add more methods if needed
}


//MARK: 플로팅버튼 델리게이트
extension MonthlyView: FloatingButtonDelegate {
    func showAddTaskActionSheet() {
        let addTaskSheet = AddTaskActionSheet(taskService: taskService) { [weak self] in
            guard let self = self else { return }
            taskTableView.tasks = self.taskService.fetchActiveTasks()
            taskTableView.tableView.reloadData()
        }
        present(addTaskSheet, animated: true, completion: nil)
    }
}

//MARK: SetUpUI
extension MonthlyView {
     private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(self.profileView)
        view.addSubview(self.searchBar)
        view.addSubview(self.calendarView)
        view.addSubview(self.taskTableView.tableView)
        view.addSubview(floatingButton.floatingButton)

        // AutoResizeMask 끄기
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.taskTableView.tableView.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.floatingButton.translatesAutoresizingMaskIntoConstraints = false
            
        // Profile View 제약
        NSLayoutConstraint.activate([
            self.profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.profileView.heightAnchor.constraint(equalToConstant: 100)
        ])
            
        // SearchBar 제약
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.profileView.bottomAnchor, constant: 10),
            self.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
            
        // Calendar View 제약
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10),
            self.calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Tasks TableView 제약
        NSLayoutConstraint.activate([
            self.taskTableView.tableView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: 10),
            self.taskTableView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.taskTableView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.taskTableView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
            
        // Floating Button 제약
        NSLayoutConstraint.activate([
            floatingButton.floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.floatingButton.widthAnchor.constraint(equalToConstant: 50),
            floatingButton.floatingButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}



