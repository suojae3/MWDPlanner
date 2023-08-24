//
//  File.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/23.

import Foundation

// 테이블뷰 task 바로 생성
protocol CreateTaskDelegate: AnyObject {
    func createTask()
}

// action sheet 화면 dimiss
protocol SaveButtonDelegate: AnyObject {
    func dismissSheet()
}
                                


class AddTaskSheetModel {
    
    //델리게이트 패턴
    weak var saveTaskDelegate: SaveButtonDelegate?
    weak var createTaskDelegate: CreateTaskDelegate?
    
    //CRUD 메서드
    private let taskService = TaskService()
    
    //addTaskSheet 사용자 입력값 task형태로 가져오기
    var provideTaskDetails: (() -> Task?)?
    
    
    @objc func saveButtonTapped() {
        
        if let task = provideTaskDetails?() {
            taskService.saveTask(task)
            
            // 테이블뷰 task 바로 생성
            createTaskDelegate?.createTask()
            print("Task saved successfully!")
            saveTaskDelegate?.dismissSheet()
        } else {
            print("Failed to gather task details!")
        }
    }
}

