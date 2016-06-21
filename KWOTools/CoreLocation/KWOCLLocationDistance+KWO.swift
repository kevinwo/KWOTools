//
//  KWOCLLocationDistance+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/14/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import CoreLocation.CLLocation

extension CLLocationDistance {
    public func toMiles() -> CLLocationDistance {
        return self * 0.00062137
    }

    public func toKilometers() -> CLLocationDistance {
        return self / 1000.0
    }
}