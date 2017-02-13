//
//  HolidayInfoViewModel.swift
//  Holidays
//
//  Created by Suman Chatterjee on 05/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation

class HolidayInfoViewModel {
    
    var holidayLists : [HolidayInfo] = []


    // MARK: - Initialization methods
    
    static let sharedInstance = HolidayInfoViewModel()

}

extension  HolidayInfoViewModel{
    
    func holidayBuilder(for records: [String: Any] )  {
        
         guard let item = records["holidays"] as? [String: Any] else {
            return;
        }
        
        holidayLists.removeAll()
        
        for (_,value) in item {
            
            let c   = value as? [[String:Any]] ?? []
            
            for s in c {
                
                let name :String = s["name"] as! String? ?? ""
                let date :String = s["date"] as! String? ?? ""
                
                let holidayInfo = HolidayInfo(date:date, name:name)
                holidayLists.append(holidayInfo)
                
            }
            
        }
        
        self.holidayLists = holidayLists.sorted{ $0.date < $1.date }
        
        NotificationCenter.default.post(name: HolidayInfoViewModel.Notification.didLoadNewHoliday.name, object: nil)
        
        
    }
    
}


extension HolidayInfoViewModel {
    
    struct Notification: NotificationNameRepresentable, RawRepresentable, ExpressibleByStringLiteral {
        
        let rawValue: String
        init?(rawValue: String) { self.rawValue = rawValue }
        init(stringLiteral value: String) { self.rawValue = value }
        init(extendedGraphemeClusterLiteral value: String) { self.rawValue = value }
        init(unicodeScalarLiteral value: String) { self.rawValue = value }
        
        static let didLoadNewHoliday: Notification = "didLoadNewHoliday"
 //       static let didUpdateWithNewRegion: Notification = "didUpdateWithNewRegion"
    }
    
    // objc compatibility - remove after fully swiftification
    class func appUpdateWithNewHolidayNotification() -> String {
        return Notification.didLoadNewHoliday.name.rawValue
    }
}

