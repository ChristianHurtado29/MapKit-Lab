//
//  School.swift
//  MapKit Lab
//
//  Created by Christian Hurtado on 2/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct School: Codable {
    let schoolName: String
    let city: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case city
        case latitude
        case longitude
    }
    
}
