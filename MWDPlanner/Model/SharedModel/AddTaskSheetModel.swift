//
//  File.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/23.


protocol SaveButtonDelegate: AnyObject {
    func dismissSheet()
}
                                

import Foundation

class AddTaskModel {
    
    weak var delegate: SaveButtonDelegate?
    
    let taskService = TaskService()
    
    var provideTaskDetails: (() -> Task?)?
    
    @objc func saveButtonTapped() {
        
        if let task = provideTaskDetails?() {
            taskService.saveTask(task)
            print("Task saved successfully!")
        } else {
            print("Failed to gather task details!")
        }
        delegate?.dismissSheet()
    }
}

