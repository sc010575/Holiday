//
//  DownloadManager.swift
//  Holidays
//
//  Created by Suman Chatterjee on 03/02/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class DownloadManager: NSObject {
    public typealias DownloadCompletionHandler = (_ response: [String: Any]?, _ cancelled: Bool) -> Void

    
    static func downloadHolidays(countryCode:String,completionhandler:@escaping DownloadCompletionHandler)  {
        
        let endpoint: String = HolidayURL + HolidayTestApiKey + "&country=" + countryCode + "&year=2017"
        
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                completionhandler(nil,false)

                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        completionhandler(json,true)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
    }

}
