//
//  RepoRowCell.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class RepoRowCell: UITableViewCell, Instantiatable {
    
    @IBOutlet fileprivate weak var lblRepoName: UILabel!
    @IBOutlet fileprivate weak var lblDescription: UILabel!
    @IBOutlet weak var stackViewDetails: UIStackView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblStarCount: UILabel!
    @IBOutlet weak var stackViewStar: UIStackView!
    @IBOutlet weak var stackViewLanguage: UIStackView!
    
    var repo: RepoModel? {
        didSet {
            guard let repo = repo else {
                return
            }
            lblRepoName.text = repo.name
            lblDescription.text = repo.descriptionField
            
            if let stargazersCount = repo.stargazersCount, stargazersCount > 0 {
                stackViewStar.isHidden = false
                lblStarCount.text = "\(stargazersCount)"
            } else {
                stackViewStar.isHidden = true
            }
            if let language = repo.language, !language.isEmpty {
                stackViewLanguage.isHidden = false
                lblLanguage.text = language
            } else {
                stackViewLanguage.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        stackViewDetails.setCustomSpacing(15, after: lblDescription)
    }
}

