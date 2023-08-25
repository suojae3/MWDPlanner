

import Foundation

// CRUD 함수 제공 클래스
class TaskService {

    // UserDefaults 저장소내 어디에 저장되었는지 알려주는 위치 key
    private let tasksKey = "tasks"
    
    static let shared = TaskService()
    
    
    // 파라미터에는 넘겨줄 값을 넣어주기
    var fetchCompletion: (([Task]) -> Void)?
    
    private init() {}
    
    // MARK: 1
    //UserDefaults로 부터 Task 객체 배열 가져오기 - 입력
    func fetchTasks() -> [Task] {
        //UserDefaults내 주어진 키에 해당하는 데이터 확인하기
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           
            // Task 객체배열로 decode하기
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            
            // decode가 완요되면 task를 리턴하기 - 출력
            return tasks
        }
        
        // 만약 가져온 데이터가 비어있거나 디코딩에 실패한다면 빈배열 리턴하기 - 출력
        return []
    }
    
    // Task 타입의 새로운 데이터를 UserDefaults에 저장하기 - 입력
    func save(_ task: Task) {
        // fetchTasks()를 통해 기존 데이터 가져오기
        var tasks = fetchTasks()
        
        // tasks 배열에 새로 받아온 task 첫번째에 insert
        tasks.insert(task, at: 0)
        
        // 이제 다시 encode 해주기
        if let data = try? JSONEncoder().encode(tasks) {
            // encode가 성공했다면 UserDefaults에 넣어주기
            UserDefaults.standard.set(data, forKey: tasksKey)
            
            //MARK: 3
            self.fetchCompletion?(tasks)
        }
    }
}
