//
//  File.swift
//  MWDPlanner
//
//  Created by ㅣ on 2023/08/23.
//

import Foundation


import UIKit



protocol FloatingButtonModelDelegate: AnyObject {
    func showAddTaskActionSheet()
}

class FloatingButtonModel {
    
    weak var delegate: FloatingButtonModelDelegate?

    
    @objc func buttonTapped() {
        print("buttonTapped")

        delegate?.showAddTaskActionSheet()

    }
}



