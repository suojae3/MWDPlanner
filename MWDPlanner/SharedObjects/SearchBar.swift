

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchFilter(with searchText: String)
}

class SearchBarController:NSObject {
    
    var delegate: SearchBarDelegate?
    
     let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
            searchBar.placeholder = "할 일을 검색해보세요"
            searchBar.searchTextField.backgroundColor = UIColor.clear

           return searchBar
       }()
    
    override init() {
        super.init()
        searchBar.delegate = self
    }
}

extension SearchBarController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchFilter(with: searchText)
        print("user input값 들어오는지 테스트")
    }
}



