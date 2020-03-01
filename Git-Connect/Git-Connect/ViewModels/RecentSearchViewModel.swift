//
//  RecentSearchViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class RecentSearchViewModel: NSObject {
    
    var selectionHandler: ((String) -> Void)?
    let recentSearchesManager = RecentSearchesManager()
    
}

extension RecentSearchViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchesCell.defaultReuseIdentifier,
                                                 for: indexPath) as! RecentSearchesCell
        cell.searchLabel.text = recentSearchesManager.recentSearches[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchesManager.recentSearches.count
    }
    
}

extension RecentSearchViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = recentSearchesManager.recentSearches[indexPath.row]
        selectionHandler?(query)
    }
    
}


