import UIKit







class AddTaskActionSheet: UIViewController {
    

    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Task"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Title"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        return textView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(AddTaskActionSheet.self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    
    @objc func saveButtonTapped() {
        print("saveButtonTapped")
    }
    

    
}


//MARK: LifeCycle

extension AddTaskActionSheet {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}


extension AddTaskActionSheet {
    func setupUI() {

            view.backgroundColor = .white
            view.addSubview(titleLabel)
            view.addSubview(titleTextField)
            view.addSubview(datePicker)
            view.addSubview(descriptionTextView)
            view.addSubview(saveButton)
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
             titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
             // titleTextField constraints
             titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
             titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             
             // datePicker constraints
             datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
             datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             
             // descriptionTextView constraints
             descriptionTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
             descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
             
             // saveButton constraints
             saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
             saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         ])
     }
    

}


