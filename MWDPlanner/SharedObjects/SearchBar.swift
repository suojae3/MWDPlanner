

import UIKit





class SearchBarClass { 
    
     let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
            searchBar.placeholder = "할 일을 검색해보세요"
            searchBar.searchTextField.backgroundColor = UIColor.clear

           return searchBar
       }()
    
    
}



