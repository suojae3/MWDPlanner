//
//  ViewController.swift
//  MyPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit


protocol PopUpActionSheetDelegate {
    func popUpActionSheet(_ view: MonthlyView)
}


//MARK: Instantiation
class MonthlyView: UIViewController {

    
    private let foatingButton = FloatingButton()
        
    
    //컴포넌트
    let profileView: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           return view
       }()
       
    let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
           return searchBar
       }()
       
       let calendarView: UIView = {
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
        setUpUI()
    }
}




//MARK: SeupUI
extension MonthlyView {
    
    func setUpUI() {
        
            view.addSubview(self.profileView)
            view.addSubview(self.searchBar)
            view.addSubview(self.calendarView)
            view.addSubview(foatingButton.tasksTableView)
            view.addSubview(foatingButton.floatingButton)
      
        
        
        // AutoResizeMask 끄기
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        foatingButton.tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        foatingButton.floatingButton.translatesAutoresizingMaskIntoConstraints = false
            
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
            foatingButton.tasksTableView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: 10),
            foatingButton.tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foatingButton.tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foatingButton.tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
            
        // Floating Button 제약
        NSLayoutConstraint.activate([
            foatingButton.floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            foatingButton.floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            foatingButton.floatingButton.widthAnchor.constraint(equalToConstant: 50),
            foatingButton.floatingButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}


