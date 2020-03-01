//
//  SearchVC.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class SearchVC: GCBaseViewController {
    
    enum C {
        static let refreshControlAttributeTitle = NSAttributedString(string: GCConstants.PlaceHolder.Text.pullToRefresh,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),
                                                                                  NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        static let refreshControlTintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        static let contentCellHeight: CGFloat = 70.0
        static let loadingCellHeight: CGFloat = 44.0
        static let userDetailSegue = "navigateToUserDetails"
    }
    
    fileprivate weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recentSearchesTableView: UITableView!
    
    lazy var viewModel: SearchViewModel! = SearchViewModel()
    var emptyStateView = EmptyView.instantiate()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = C.refreshControlTintColor
        refreshControl.attributedTitle = C.refreshControlAttributeTitle
        refreshControl.addTarget(self, action: #selector(reloadUserList), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.userDetailSegue,
            let dest = segue.destination as? ProfileVC,
            let userModel = sender as? UserModel {
            dest.viewModel = ProfileViewModel.init(user: userModel)
        }
    }
}

extension SearchVC {
    
    func setupUI() {
        self.userTableUISetup()
        if let searchViewModel = viewModel {
            view.bringSubviewToFront(recentSearchesTableView)
            recentSearchesTableView.dataSource = searchViewModel.recentSearchViewModel
            recentSearchesTableView.delegate = searchViewModel.recentSearchViewModel
            
            searchViewModel.recentSearchViewModel.selectionHandler = {
                [unowned self] query in
                self.viewModel?.searchQuery = query
                self.searchBar.text = query
                self.searchBar.resignFirstResponder()
            }
        }
        recentSearchesTableView.register(RecentSearchesCell.defaultNib, forCellReuseIdentifier: RecentSearchesCell.defaultReuseIdentifier)
        recentSearchesTableView.isHidden = true
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = GCConstants.PlaceHolder.Text.userSearchbarPlaceHolder
        searchBar.tintColor = .red
        navigationItem.titleView = searchBar
        self.searchBar = searchBar
    }
    
    func userTableUISetup() {
        UserRowCell.register(withTableView: tableView)
        LoadingCell.register(withTableView: tableView)
        
        tableView.insertSubview(refreshControl, at: 0)

        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.updateLabel(string: GCConstants.PlaceHolder.Text.noRecordFound)
        view.addSubview(emptyStateView)
        emptyStateView.addToView(view: view)
        view.bringSubviewToFront(emptyStateView)
        emptyStateView.isHidden = true
    }
    
    @objc func reloadUserList() {
        viewModel.reloadUsers()
        guard let vm = viewModel else {
            return
        }
        if vm.searchQuery == nil, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    // api call status binding with viewcontroller
    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }
}

extension SearchVC {
    
    // method will call when api call status changed
    func viewModelStateChange(change: UserListState.Change) {
        
        Helper.dispatchAsyncMain { [unowned self] in
            switch change {
            case .none:
                break
            case .fetchStateChanged:
                if !self.viewModel.isSearchListEmpty {
                    self.loader(show: false)
                    break
                }
                self.loader(show: self.viewModel.isFetching)
            case .usersChanged(let collectionChange):
                switch collectionChange {
                case .reload:
                    // Reload table view by applying collection change
                    self.tableView.applyCollectionChange(collectionChange,
                                                         toSection: PaginationSection.content.rawValue,
                                                         withAnimation: .fade)
                default:
                    self.tableView.beginUpdates()
                    if !self.viewModel.hasNextPage {
                        self.tableView.applyCollectionChange(CollectionChange.deletion(0),
                                                             toSection: PaginationSection.loading.rawValue,
                                                             withAnimation: .fade)
                    }
                    self.tableView.applyCollectionChange(collectionChange,
                                                         toSection: PaginationSection.content.rawValue,
                                                         withAnimation: .fade)
                    self.tableView.endUpdates()
                }
                self.emptyStateView.isHidden = !self.viewModel.isSearchListEmpty
                self.refreshControl.endRefreshing()
            case .error(let userError):
                switch userError {
                case .connectionError(_):
                    UIAlertController.present(withTitle: GCConstants.PlaceHolder.Text.connectionError, description: GCConstants.PlaceHolder.Text.connectionErrorMessage)
                case .mappingFailed:
                    UIAlertController.present(withTitle: GCConstants.PlaceHolder.Text.invalidData, description: GCConstants.PlaceHolder.Text.invalidDataErrorMessage)
                case .reloadFailed:
                    UIAlertController.present(withTitle: GCConstants.PlaceHolder.Text.invalidData, description: GCConstants.PlaceHolder.Text.invalidDataErrorMessage)
                default:
                    break
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
}

