
import UIKit


protocol FloatingButtonModelDelegate: AnyObject {
    func showAddTaskActionSheet()
}


//MARK: Instantiation

class FloatingButton {
     let floatingButton: UIButton = UIButton(type: .system)
        weak var delegate: FloatingButtonModelDelegate?

    init() {
        configureFloatingButton()
    }

    private func configureFloatingButton() {
        floatingButton.backgroundColor = .blue
        floatingButton.setTitle("+", for: .normal)
        floatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        floatingButton.layer.cornerRadius = 25
        floatingButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }
        @objc func buttonTapped() {
            print("buttonTapped")
            delegate?.showAddTaskActionSheet()
        
    }
}
