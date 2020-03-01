//
//  GitHubUserListViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

enum UserListError {
    case connectionError(Error)
    case mappingFailed
    case reloadFailed
    case unknown
}

struct UserListState {
    
    fileprivate(set) var users: [UserModel] = []
    fileprivate(set) var page = Page(current: 1, total: 1)
    fileprivate(set) var fetching = false
}

extension UserListState {
    
    enum Change {
        case none
        case fetchStateChanged
        case error(UserListError)
        case usersChanged(CollectionChange)
    }
    
    mutating func setFetching(fetching: Bool) -> Change {
        self.fetching = fetching
        return .fetchStateChanged
    }
    
    mutating func reload(users: [UserModel]) -> Change {
        self.users = users
        return .usersChanged(.reload)
    }
    
    mutating func insert(users: [UserModel]) -> Change {
        let index = self.users.count
        self.users.append(contentsOf: users)
        let range = IndexSet(integersIn: index..<self.users.count)
        return .usersChanged(.insertion(range))
    }
    
    mutating func update(page: Page) {
        self.page = page
    }
}

protocol GitHubUserListViewModel {
    
    var state: UserListState { get}
    var onChange: ((UserListState.Change) -> Void)? { get set }
    
    func reloadUsers()
    func loadMoreUsers()
}

