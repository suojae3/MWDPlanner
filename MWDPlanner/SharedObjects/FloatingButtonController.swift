import UIKit

protocol FloatingButtonDelegate: AnyObject {
    func showAddTaskActionSheet()
}

class FloatingButtonController {
    
    // MARK: - Properties
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "pencil.and.outline")?
            .withConfiguration(UIImage.SymbolConfiguration(scale: .large))
        button.tintColor = .black
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: FloatingButtonDelegate?
    
    // MARK: - Initialization
    init() {}
    
    // MARK: - Actions
    @objc private func buttonTapped() {
        print("buttonTapped")
        delegate?.showAddTaskActionSheet()
    }
}
