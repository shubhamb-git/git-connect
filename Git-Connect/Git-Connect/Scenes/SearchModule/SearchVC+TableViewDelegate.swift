//
//  SearchVC+TableViewDelegate.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit


extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        if section == .content {
            if viewModel.state.page.hasNextPage,
                indexPath.row == (viewModel.state.users.count - PaginationSection.offset) {
                self.viewModel.loadMoreUsers()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return UITableView.automaticDimension
        case .loading:
            return C.loadingCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return C.contentCellHeight
        case .loading:
            return C.loadingCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            tableView.deselectRow(at: indexPath, animated: true)
            let user = viewModel.state.users[indexPath.row]
            self.performSegue(withIdentifier: "navigateToUserDetails", sender: user)
        case .loading:
            print("Tapped on loading cell")
        }
    }
}

