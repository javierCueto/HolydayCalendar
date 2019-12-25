//
//  HolidayRequest.swift
//  HolydayCalendar
//
//  Created by José Javier Cueto Mejía on 25/12/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import Foundation

enum HolidayError:Error{
    case noDataAvailable
    case caNotProcessData
}

struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "0d1bc2bdcb6a381ff5c5a89bd42568c18c610184"
    
    
    init(countryCode:String){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail],HolidayError>)->Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _, _ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
                
            }catch{
                completion(.failure(.caNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
