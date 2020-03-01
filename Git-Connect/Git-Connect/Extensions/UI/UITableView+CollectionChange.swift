//
//  UITableView+CollectionChange.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension UITableView {
    
    func applyCollectionChange(_ change: CollectionChange, toSection section: Int, withAnimation animation: UITableView.RowAnimation) {
        func makeIndexPath(using index: Int) -> IndexPath {
            return IndexPath(row: index, section: section)
        }
        
        func makeIndexPaths(using indexSet: IndexSet) -> [IndexPath] {
            return indexSet.map { makeIndexPath(using: $0) }
        }
        
        switch change {
        case .update(let indexes):
            reloadRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .insertion(let indexes):
            insertRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .deletion(let indexes):
            deleteRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .move(let from, let to):
            moveRow(at: makeIndexPath(using: from), to: makeIndexPath(using: to))
        case .reload:
            reloadData()
        }
    }
}

