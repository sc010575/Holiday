//
//  HolidayDetailsViewController.swift
//  Holidays
//
//  Created by Suman Chatterjee on 05/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class HolidayDetailsViewController: UITableViewController {
    
    var holidayLists : [HolidayInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        holidayLists = HolidayInfoViewModel.sharedInstance.holidayLists
        
        NotificationCenter.default.addObserver(self, selector: #selector(HolidayDetailsViewController.holidayListgUpdated(_:)), name:HolidayInfoViewModel.Notification.didLoadNewHoliday.name, object: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidayLists.count
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let holidayInfo : HolidayInfo = holidayLists[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HolidayDetailTableViewCell.self), for: indexPath)
        
        guard let holidayCell = cell as? HolidayDetailTableViewCell else {
            return cell
        }
        holidayCell.name.text = holidayInfo.name
        holidayCell.date.text = holidayInfo.date
        
        return cell
    }


    private dynamic func holidayListgUpdated(_ notification: Notification) {
        
        DispatchQueue.main.async {
            
            self.holidayLists = HolidayInfoViewModel.sharedInstance.holidayLists
            self.tableView.reloadData()
        
        }
 
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: HolidayInfoViewModel.Notification.didLoadNewHoliday.name, object: nil)
    }

}
