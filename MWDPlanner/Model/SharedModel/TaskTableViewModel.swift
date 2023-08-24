
import Foundation


class TaskTableViewModel {
    
    private var tasks: [Task] = []
    // task개수
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    // 특정 task 인덱스 가져오기
    func task(at index: Int) -> Task {
        return tasks[index]
    }
}
