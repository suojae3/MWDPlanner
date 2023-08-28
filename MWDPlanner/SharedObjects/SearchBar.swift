

import UIKit

protocol SearchBarDelegate {
    func searchFilter()
}




class SearchBarClass:NSObject {
    
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


extension SearchBarClass: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("user input value detectedSearchBarDelegate")
    }


    
}



