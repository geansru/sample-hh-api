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
    @IBOutlet weak var companyLogoImage: UIImageView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var vacancyNameLabel: UILabel!
    
    // MARK: Public fields
    var vacancy: Vacancy? {
        didSet {
            Thread.shared.main {
                self.updateTextOnLabel((self.vacancy?.salary)!, label: self.salaryLabel)
                self.updateTextOnLabel((self.vacancy?.company?.companyName)!, label: self.companyLabel)
                self.updateTextOnLabel((self.vacancy?.vacancyName)!, label: self.vacancyNameLabel)
                self.companyLogoImage.loadLogo(forCompany: self.vacancy!.company!)
            }
        }
    }

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        companyLogoImage.image = UIImage()
    }

    // MARK: Helper
    private func updateTextOnLabel(text: String, label: UILabel) {
        label.text = text
    }
}
