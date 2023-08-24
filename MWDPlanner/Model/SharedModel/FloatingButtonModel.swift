//
//  File.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/23.
//

import Foundation

// 메인뷰컨에서 actionsheet 띄우기 delegate
protocol FloatingButtonModelDelegate: AnyObject {
    func showAddTaskActionSheet()
}



class FloatingButtonModel {
    
    weak var delegate: FloatingButtonModelDelegate?

    @objc func buttonTapped() {
        print("buttonTapped")
        
        // 메인뷰컨에서 actionsheet 띄우기 delegate
        delegate?.showAddTaskActionSheet()
    }
}



