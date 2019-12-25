//
//  Holiday.swift
//  HolydayCalendar
//
//  Created by José Javier Cueto Mejía on 25/12/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import Foundation


struct HolidayResponse:Decodable{
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable{
    var name:String
    var date:DateInfo
}

struct DateInfo: Decodable {
    var iso:String
}
