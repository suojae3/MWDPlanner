import UIKit

class AddTaskActionSheetController: UIViewController {
    
    // MARK: - Properties
    
    // Service & Callback
    private let taskService: TaskService
    private let dismissCallback: () -> Void
    
    // UI Components
    private let titleLabel = UILabel(
        text: "Add Task",
        font: UIFont.boldSystemFont(ofSize: 24),
        alignment: .center
    )
    
    private let titleTextField = UITextField(
        placeholder: "Task Title",
        borderStyle: .roundedRect
    )
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.set(
            borderColor: UIColor.lightGray.cgColor,
            borderWidth: 1.0,
            cornerRadius: 5.0
        )
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    init(taskService: TaskService, dismissCallback: @escaping () -> Void) {
        self.taskService = taskService
        self.dismissCallback = dismissCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        [titleLabel, titleTextField, datePicker, descriptionTextView, saveButton].forEach { view.addSubview($0) }

        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        titleLabel.centerX(inView: view)
        
        titleTextField.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 50, left: 20, bottom: 0, right: 20)
        )
        
        datePicker.anchor(
            top: titleTextField.bottomAnchor,
            leading: view.leadingAnchor,
            padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        descriptionTextView.anchor(
            top: datePicker.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 150))
        
        saveButton.anchor(
            top: descriptionTextView.bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        saveButton.centerX(inView: view)
    }
    
    // MARK: - Actions
    
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

