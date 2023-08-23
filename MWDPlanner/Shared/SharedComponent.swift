//
//  ViewController.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit



//MARK: Instantiation
class SharedComponent {
    
    private let sharedModel = SharedModel()
    
    
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


//MARK: Shared Model
extension SharedComponent {
    
    func addTask() {
        sharedModel.addTask()
    }
}




