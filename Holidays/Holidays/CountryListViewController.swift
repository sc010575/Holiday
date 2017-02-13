//
//  ViewController.swift
//  Holidays
//
//  Created by Suman Chatterjee on 02/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class CountryListViewController: UITableViewController{
    
    private let countries :[Locale.CountryInfo] = Locale.countryList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Holidays"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryInfo : Locale.CountryInfo = countries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryListTableViewCell.self), for: indexPath)
        
        guard let countryCell = cell as? CountryListTableViewCell else {
            return cell
        }
        countryCell.countryName.text = countryInfo.country
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = countries[indexPath.row]
        let countryCode = country.countryCode
        print(countryCode)
        
        DownloadManager.downloadHolidays(countryCode :countryCode,completionhandler: { (response,cancled) in
            
            guard let holidayResponses = response else {
                return
            }
            HolidayInfoViewModel.sharedInstance.holidayBuilder(for:holidayResponses)
            
        })
        
    }
    
    
    
}

