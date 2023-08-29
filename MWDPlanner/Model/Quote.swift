//import Foundation
//
//struct Quote: Codable {
//    let content: String
//}
//
//class QuoteService {
//    static let shared = QuoteService()
//
//    private init() {}
//
//    func fetchRandomQuote(completion: @escaping (String?) -> Void) {
//        let urlString = "https://api.quotable.io/random"
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let quote = try JSONDecoder().decode(Quote.self, from: data)
//                completion(quote.content)
//            } catch {
//                print("Error:", error)
//                completion(nil)
//            }
//        }.resume()
//    }
//}

import Foundation

struct Quote: Codable {
    let content: String
}

class QuoteService {
    static let shared = QuoteService()
    
    private let cacheKey = "cachedQuote"
    
    private init() {}
    
    func fetchRandomQuote(completion: @escaping (String?) -> Void) {
        
        // 1. Check for a cached quote first
        if let cachedQuote = UserDefaults.standard.string(forKey: cacheKey) {
            completion(cachedQuote)
            
            // Optionally, you can return here if you don't want to fetch a new quote
            // when there's a cached one. But if you want to always fetch a new quote
            // and update the cache, then don't return and proceed with the fetch.
            // return
        }
        
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
                
                // 2. Cache the fetched quote in UserDefaults
                UserDefaults.standard.set(quote.content, forKey: self.cacheKey)
                
                completion(quote.content)
            } catch {
                print("Error:", error)
                completion(nil)
            }
        }.resume()
    }
}

