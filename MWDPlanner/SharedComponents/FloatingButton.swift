
import UIKit




//MARK: Instantiation

class FloatingButton {
    let model: FloatingButtonModel
    let floatingButton: UIButton = UIButton(type: .system)

    init(model: FloatingButtonModel) {
        self.model = model
        configureFloatingButton()
    }

    private func configureFloatingButton() {
        floatingButton.backgroundColor = .blue
        floatingButton.setTitle("+", for: .normal)
        floatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        floatingButton.layer.cornerRadius = 25
        floatingButton.addTarget(model, action: #selector(model.buttonTapped), for: .touchUpInside)
    }
}
