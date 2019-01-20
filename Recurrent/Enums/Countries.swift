//
//  Countries.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation

enum Countries: Int {
    case ukraine
    case usa
    case checkRepublic
    case japan
    case uk
    case mexico
    case australia
    
    var name: String {
        switch self {
        case .ukraine: return "Ukraine"
        case .usa: return "USA"
        case .checkRepublic: return "Check Republic"
        case .japan: return "Japan"
        case .uk: return "UK"
        case .mexico: return "Mexico"
        case .australia: return "Australia"
        }
    }
    
    var phoneCode: Int {
        switch self {
        case .ukraine: return 380
        case .usa: return 1
        case .checkRepublic: return 420
        case .japan: return 81
        case .uk: return 44
        case .mexico: return 52
        case .australia: return 61
        }
    }
    
    var numberLength: Int {
        switch self {
        case .ukraine, .checkRepublic:
            return 9
        case .usa, .japan, .mexico, .uk, .australia:
            return 10
        }
    }
    
    var states: [String] {
        switch self {
        case .usa: return USAstates
        default: return ["N/A"]
        }
    }
}

let USAstates = ["Alaska",
              "Alabama",
              "Arkansas",
              "American Samoa",
              "Arizona",
              "California",
              "Colorado",
              "Connecticut",
              "District of Columbia",
              "Delaware",
              "Florida",
              "Georgia",
              "Guam",
              "Hawaii",
              "Iowa",
              "Idaho",
              "Illinois",
              "Indiana",
              "Kansas",
              "Kentucky",
              "Louisiana",
              "Massachusetts",
              "Maryland",
              "Maine",
              "Michigan",
              "Minnesota",
              "Missouri",
              "Mississippi",
              "Montana",
              "North Carolina",
              "North Dakota",
              "Nebraska",
              "New Hampshire",
              "New Jersey",
              "New Mexico",
              "Nevada",
              "New York",
              "Ohio",
              "Oklahoma",
              "Oregon",
              "Pennsylvania",
              "Puerto Rico",
              "Rhode Island",
              "South Carolina",
              "South Dakota",
              "Tennessee",
              "Texas",
              "Utah",
              "Virginia",
              "Virgin Islands",
              "Vermont",
              "Washington",
              "Wisconsin",
              "West Virginia",
              "Wyoming"]
