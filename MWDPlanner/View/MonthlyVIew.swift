//
//  ViewController.swift
//  MyPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit




//MARK: Instantiation
class MonthlyView: UIViewController {
    
    
    //테이블뷰 인스턴스
    private let taskTableView = TaskTableView(taskTableViewModel: TaskTableViewModel(), addTaskSheetModel: AddTaskSheetModel())
    
    // 플로팅 버튼 인스턴스
    private let floatingButton = FloatingButton(model: FloatingButtonModel())
    
    // 플로팅 버튼 델리게이트 패턴(화면전환 - ActionSheet)
    weak var delegate: FloatingButtonModelDelegate?
    

    //컴포넌트
    private let profileView: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           return view
       }()
       
    private let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
           return searchBar
       }()
       
    private let calendarView: UIView = {
           let view = UIView()
           view.backgroundColor = .black
           return view
       }()
}



//MARK: LifeCycle
extension MonthlyView {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 컴포넌트 constraints
        setUpUI()
        
        // 플로팅 버튼 델리게이트 패턴(화면전환 - ActionSheet)
        floatingButton.model.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //테이블뷰 데이터 업데이트
        taskTableView.tasksTableView.reloadData()
    }
}


//MARK: 프로토콜 - 델리게이트 패턴 구현
extension MonthlyView: FloatingButtonModelDelegate {
    func showAddTaskActionSheet() {
        let addTaskSheet = AddTaskActionSheet(model: AddTaskSheetModel())
        present(addTaskSheet, animated: true, completion: nil)
    }
}


//MARK: SetUpUI
extension MonthlyView {
    
     private func setUpUI() {
        
        view.addSubview(self.profileView)
        view.addSubview(self.searchBar)
        view.addSubview(self.calendarView)
        view.addSubview(self.taskTableView.tasksTableView)
        view.addSubview(floatingButton.floatingButton)

        // AutoResizeMask 끄기
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.taskTableView.tasksTableView.translatesAutoresizingMaskIntoConstraints = false
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
            self.taskTableView.tasksTableView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: 10),
            self.taskTableView.tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.taskTableView.tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.taskTableView.tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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





