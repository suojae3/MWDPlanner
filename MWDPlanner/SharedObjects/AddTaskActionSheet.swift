import UIKit

class AddTaskActionSheet: UIViewController {
    private let taskService: TaskService
    private let saveButton: UIButton = UIButton(type: .roundedRect)
    private let dismissCallback: () -> Void

    init(taskService: TaskService, dismissCallback: @escaping () -> Void) {
        self.taskService = taskService
        
        //reload를 위한 콜백함수처리
        self.dismissCallback = dismissCallback
        super.init(nibName: nil, bundle: nil)
        configureSaveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Task"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Title"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        return textView
    }()
    
    
    private func configureSaveButton() {
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        guard
            let title = titleTextField.text, !title.isEmpty,
            let description = descriptionTextView.text, !description.isEmpty
        else { return }
        
        let dueDate = self.datePicker.date
        let newTask = Task(title: title, dueDate: dueDate, description: description)
        
        taskService.save(newTask)
        dismiss(animated: true, completion: dismissCallback)
    }
}

//MARK: LifeCycle

extension AddTaskActionSheet {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}



//MARK: UI셋팅

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
             
             titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
             titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             
             datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
             datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             
             descriptionTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
             descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
             
             saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
             saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         ])
     }
    

}