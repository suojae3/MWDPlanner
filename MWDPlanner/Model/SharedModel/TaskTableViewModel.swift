
import Foundation



class TaskTableViewModel {
    
    private var tasks: [Task] = []
    
    private let taskService: TaskService
    
    init(service: TaskService) {
        self.taskService = service
        
        // 하위에서 상위로 쏠 때는 클로저 활용
        // 1. 하위는 하위에서 클로저를 프로퍼티로 갖는다
        // 2. 상위에서는 하위의 인스턴스를 가지고 있기 때문에 이 친구 클로저를 넣어준다
        // 3. 하위에서는 적당한 시기에 호출해준다

        // MARK: 2
        self.taskService.fetchCompletion = { [weak self] taskArray in
            self?.tasks = taskArray
        }
        
        tasks = taskService.fetchTasks()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func task(at index: Int) -> Task {
        
        return tasks[index]
    }
}

