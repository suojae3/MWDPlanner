import UIKit

// MARK: - 프로토콜 정의

protocol SearchBarDelegate: AnyObject {
    func searchFilter(with searchText: String)
}

// MARK: - SearchBarController

class SearchBarController: NSObject {
    
    // MARK: - 인스턴스 셋팅
    
    weak var delegate: SearchBarDelegate?
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "할 일을 검색해보세요"
        sb.searchTextField.backgroundColor = .clear
        return sb
    }()
    
    // MARK: - 초기화 셋팅
    
    override init() {
        super.init()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate

extension SearchBarController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchFilter(with: searchText)
        print("User input received")
    }
}
