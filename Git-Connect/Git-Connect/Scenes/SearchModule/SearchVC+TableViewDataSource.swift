//
//  SearchVC+TableViewDataSource.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension SearchVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PaginationSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = PaginationSection(rawValue: section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return viewModel.state.users.count
        case .loading:
            return viewModel.state.page.hasNextPage ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserRowCell.defaultReuseIdentifier, for: indexPath) as? UserRowCell else {
                fatalError("Invalid cell Identifier! Check `UserRowCell` identifier function.")
            }
            let user = viewModel.state.users[indexPath.row]
            userCell.user = user
            return userCell
        case .loading:
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.defaultReuseIdentifier, for: indexPath) as! LoadingCell
            loadingCell.loader.startAnimating()
            return loadingCell
        }
    }
}

