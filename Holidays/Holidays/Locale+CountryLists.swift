//
//  Locale+CountryLists.swift
//  Holidays
//
//  Created by Suman Chatterjee on 02/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation

extension Locale {
    
    struct CountryInfo{
        
        var country : String
        var countryCode : String
    }
    
    static func countryList() -> [CountryInfo] {
 
        let contryCodes = Locale.isoRegionCodes.sorted()
        var countryInfos : [CountryInfo] = []
        
        
        for contryCode in contryCodes {
            
            let countryName  = Locale.current.localizedString(forRegionCode: contryCode) ?? ""
            
            let countryInfo = CountryInfo(country: countryName, countryCode: contryCode)
            countryInfos.append(countryInfo)
        }
        
        let sortedArray = countryInfos.sorted {
            $0.country < $1.country
        }
        return sortedArray
    }
    
}

