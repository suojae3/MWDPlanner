

import Foundation


struct Task: Codable {
    let id: UUID
    var title: String
    var dueDate: Date
    var description: String
}
