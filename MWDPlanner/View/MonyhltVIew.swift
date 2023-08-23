//
//  ViewController.swift
//  MyPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit

class MonthlyView: UIViewController {

    private let monthlyModule = MonthlyModule()
    private let sharedModule = SharedModule()

}

//MARK: ViewModel 연결
extension MonthlyView {
    
    // 플로팅 버튼
    @objc func didTapAddTask() {
        sharedModule.addTask()
    }
}


//MARK: LifeCycle
extension MonthlyView {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setupConstraints()
    }
}


//MARK: AddView
extension MonthlyView {
    func addView() {
        view.addSubview(monthlyModule.profileView)
        view.addSubview(monthlyModule.searchBar)
        view.addSubview(monthlyModule.calendarView)
        view.addSubview(sharedModule.tasksTableView)
        view.addSubview(sharedModule.floatingButton)
        sharedModule.floatingButton.addTarget(self, action: #selector(didTapAddTask), for: .touchUpInside)
    }
}

//MARK:  UI Constraints
extension MonthlyView {
    
    func setupConstraints() {
        
        // AutoResizeMask 끄기
        monthlyModule.profileView.translatesAutoresizingMaskIntoConstraints = false
        monthlyModule.searchBar.translatesAutoresizingMaskIntoConstraints = false
        monthlyModule.calendarView.translatesAutoresizingMaskIntoConstraints = false
        sharedModule.tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        sharedModule.floatingButton.translatesAutoresizingMaskIntoConstraints = false
            
        // Profile View 제약
        NSLayoutConstraint.activate([
            monthlyModule.profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthlyModule.profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            monthlyModule.profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            monthlyModule.profileView.heightAnchor.constraint(equalToConstant: 100)
        ])
            
        // SearchBar 제약
        NSLayoutConstraint.activate([
            monthlyModule.searchBar.topAnchor.constraint(equalTo: monthlyModule.profileView.bottomAnchor, constant: 10),
            monthlyModule.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            monthlyModule.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
            
        // Calendar View 제약
        NSLayoutConstraint.activate([
            monthlyModule.calendarView.topAnchor.constraint(equalTo: monthlyModule.searchBar.bottomAnchor, constant: 10),
            monthlyModule.calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            monthlyModule.calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            monthlyModule.calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Tasks TableView 제약
        NSLayoutConstraint.activate([
            sharedModule.tasksTableView.topAnchor.constraint(equalTo: monthlyModule.calendarView.bottomAnchor, constant: 10),
            sharedModule.tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sharedModule.tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sharedModule.tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
            
        // Floating Button 제약
        NSLayoutConstraint.activate([
            sharedModule.floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sharedModule.floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            sharedModule.floatingButton.widthAnchor.constraint(equalToConstant: 50),
            sharedModule.floatingButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}





