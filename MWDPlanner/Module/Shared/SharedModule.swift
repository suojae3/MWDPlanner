//
//  ViewController.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/22.
//

import UIKit

class SharedModule {
    
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

extension SharedModule {
    
    func addTask() {
        print("addTask 테스트")
    }
    
    
    
}




