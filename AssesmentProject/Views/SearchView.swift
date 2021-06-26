//
//  SearchView.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func searchBeginEditing(input: String)
}

class SearchView: UICollectionReusableView, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    weak var searchDelegate: SearchDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.placeholder = "Search here"
        // Initialization code
    }
            
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let delegate = self.searchDelegate, let searchText = searchBar.text {
            delegate.searchBeginEditing(input: searchText)
        }
    }
}
