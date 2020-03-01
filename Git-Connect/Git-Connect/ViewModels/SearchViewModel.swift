//
//  SearchViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class SearchViewModel: GitHubUserListViewModel {
    
    fileprivate(set) var state = UserListState()
    fileprivate(set) var recentSearchViewModel = RecentSearchViewModel()
    
    var onChange: ((UserListState.Change) -> Void)?
    
    var isFetching: Bool {
        return self.state.fetching
    }
    
    var isSearchListEmpty: Bool {
        return self.state.users.isEmpty
    }
    
    var hasNextPage: Bool {
        return self.state.page.hasNextPage
    }
    
    var searchQuery: String? {
        didSet {
            _ = state.reload(users: [])
            reloadUsers()
        }
    }
    
    func clearUsers() {
        searchQuery = nil
        state.update(page: Page.default)
        onChange?(state.reload(users: []))
    }
    
    func reloadUsers() {
        guard let query = searchQuery else { return }
        state.update(page: Page.default)
        fetchUsers(with: query, page: state.page.currentPage) { [weak self] (users) in
            guard let strongSelf = self else { return }
            
            strongSelf.onChange?(strongSelf.state.reload(users: users))
            
            // If query return some users, add query to last searches list.
            if users.isEmpty == false {
                strongSelf.recentSearchViewModel.recentSearchesManager.addSearchQuery(query)
            }
        }
    }
    
    func loadMoreUsers() {
        guard let query = searchQuery else { return }
        guard state.page.hasNextPage else { return }
        fetchUsers(with: query, page: state.page.getNextPage()) { [weak self] (users) in
            guard let strongSelf = self else { return }
            
            strongSelf.onChange?(strongSelf.state.insert(users: users))
        }
    }
}

extension SearchViewModel {
    
    func fetchUsers(with query: String, page: Int, handler: @escaping ([UserModel]) -> Void) {
        self.onChange?(self.state.setFetching(fetching: true))
        
        let router = WSRouter.searchUser(query, page)
        
        RequestManager.shared.dataRequest(with: router) { [weak self] (response: ServiceResponse<SearchResultModel>) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let value):
                guard let users = value.items,
                    let totalPage = value.totalCount else {
                        strongSelf.onChange?(.error(.mappingFailed))
                        return
                }
                strongSelf.state.update(page: Page(current: page, total: totalPage))
                handler(users)
            case .failure(let error):
                strongSelf.onChange?(.error(.connectionError(error)))
            case .notConnectedToInternet:
                UIAlertController.internetError(retry: {
                    strongSelf.fetchUsers(with: query, page: page, handler: handler)
                })
                strongSelf.onChange?(.error(.unknown))
            }
            strongSelf.onChange?(strongSelf.state.setFetching(fetching: false))
        }
    }
}

