//
//  ViewController.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Public properties
    var records: [Vacancy]? {
        didSet {
            // TODO: Add code to refresh tableView
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VacancyCell", forIndexPath: indexPath) as! VacancyCell
        cell.vacancy = records![indexPath.row]
        return cell
    }
}