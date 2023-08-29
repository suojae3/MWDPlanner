//
//  ViewController.swift
//  MyPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit
import FSCalendar


//MARK: - MonthlyView Class

class MonthlyView: UIViewController {
    
    // MARK: - 인스턴스 셋팅
    
    private lazy var taskService = TaskService.shared
    private lazy var taskTableView = TableViewController(service: taskService, searchBar: searchBar)
    private let floatingButton = FloatingButtonController()
    private let searchBar = SearchBarController()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Inter-Medium", size: 24)
        return title
    }()
    
    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    // MARK: - 라이프사이클 셋팅
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        floatingButton.delegate = self
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "ko_KR")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        QuoteService.shared.fetchRandomQuote { [weak self] quote in
            DispatchQueue.main.async {
                self?.titleLabel.text = quote
            }
        }
    }
    
    // MARK: - UISetup
    
    private func setupUI() {
        view.backgroundColor = .white
        [titleLabel, searchBar.searchBar, calendarView, taskTableView.tableView, floatingButton.floatingButton]
            .forEach { view.addSubview($0)}

        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 100)
        )
        
        searchBar.searchBar.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10)
        )
        
        calendarView.anchor(
            top: searchBar.searchBar.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10),
            size: .init(width: 0, height: 300)
        )
        
        taskTableView.tableView.anchor(
            top: calendarView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10)
        )
        
        floatingButton.floatingButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 20),
            size: .init(width: 50, height: 50)
        )
    }
}

// MARK: - FSCalendar Delegate & DataSource

extension MonthlyView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
                
    }
    
    
    // Add more methods if needed
}

// MARK: - FloatingButton Delegate

extension MonthlyView: FloatingButtonDelegate {
    func showAddTaskActionSheet() {
        let addTaskSheet = AddTaskActionSheetController(taskService: taskService) { [weak self] in
            guard let self = self else { return }
            self.taskTableView.tasks = self.taskService.fetchActiveTasks()
            self.taskTableView.tableView.reloadData()
        }
        present(addTaskSheet, animated: true, completion: nil)
    }
}
