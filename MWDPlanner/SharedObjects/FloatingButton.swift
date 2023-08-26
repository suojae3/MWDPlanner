
import UIKit


protocol FloatingButtonDelegate: AnyObject {
    func showAddTaskActionSheet()
}


//MARK: Instantiation

class FloatingButton {
    
     let floatingButton: UIButton = UIButton(type: .system)
    weak var delegate: FloatingButtonDelegate?

    init() {
        configureFloatingButton()
    }

    private func configureFloatingButton() {
        let buttonImage = UIImage(systemName: "pencil.and.outline")!.withConfiguration(UIImage.SymbolConfiguration(scale: .large))
        floatingButton.tintColor = .black
        floatingButton.setImage(buttonImage, for: .normal)
        floatingButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }
        @objc func buttonTapped() {
            print("buttonTapped")
            delegate?.showAddTaskActionSheet()
        
    }
}
