//
//  HolidayDayInfo.swift
//  Holidays
//
//  Created by Suman Chatterjee on 03/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class HolidayInfo: NSObject {

    public private(set) var date: String
    public private(set) var name: String

    init(date:String , name: String) {
        self.date = date
        self.name = name
    }
    
}
