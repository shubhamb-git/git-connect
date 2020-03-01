//
//  SearchVC+SearchBarDelegate.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

//MARK: UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            recentSearchesTableView.reloadData()
            recentSearchesTableView.isHidden = false
            searchBar.setShowsCancelButton(true, animated: true)
        }
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            recentSearchesTableView.isHidden = true
            searchBar.setShowsCancelButton(false, animated: true)
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let model = viewModel,
            let query = searchBar.text, !query.isEmpty else { return }
        model.searchQuery = query
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.isEmpty == true {
            viewModel?.clearUsers()
        }
    }
}

