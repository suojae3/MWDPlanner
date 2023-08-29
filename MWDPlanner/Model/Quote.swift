import Foundation

struct Quote: Codable {
    let content: String
}

class QuoteService {
    static let shared = QuoteService()

    private init() {}

    func fetchRandomQuote(completion: @escaping (String?) -> Void) {
        let urlString = "https://api.quotable.io/random"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                completion(quote.content)
            } catch {
                print("Error:", error)
                completion(nil)
            }
        }.resume()
    }
}
