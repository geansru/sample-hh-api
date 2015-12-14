//
//  VacancyCell.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 14.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import UIKit

class VacancyCell: UITableViewCell {
    
    // MARK: @IBOutlets
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var vacancyNameLabel: UILabel!
    
    // MARK: Public fields
    var vacancy: Vacancy? {
        didSet {
            updateTextOnLabel((vacancy?.salary)!, label: salaryLabel)
            updateTextOnLabel((vacancy?.company?.companyName)!, label: companyLabel)
            updateTextOnLabel((vacancy?.vacancyName)!, label: vacancyNameLabel)
            logoImage.loadImageWithURL(NSURL(string: vacancy!.company!.companyLogoURL)!)
        }
    }

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: Helper
    private func updateTextOnLabel(text: String, label: UILabel) {
        label.text = text
    }
}
