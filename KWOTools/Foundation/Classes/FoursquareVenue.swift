//
//  FoursquareVenue.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/10/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

public class FoursquareVenue {

    public var id: String!
    public var name: String!
    public var rating: Double?
    public var ratingString: String? {
        get {
            if let value = rating {
                return String(format: "%.1f", value)
            }

            return nil
        }
    }
    public var canonicalURLString: String!
    public var canonicalURL: NSURL {
        get {
            return NSURL(string: self.canonicalURLString)!
        }
    }
    public var isFault: Bool {
        get {
            return canonicalURLString == nil
        }
    }

    private let kFoursquareVenueID = "id"
    private let kFoursquareVenueName = "name"
    private let kFoursquareVenueRating = "rating"
    private let kFoursquareVenueCanonicalURL = "canonicalUrl"

    public init(id: String) {
        self.id = id
    }

    public init(dict: [String: AnyObject]) {
        self.id = dict[kFoursquareVenueID] as? String
        self.name = dict[kFoursquareVenueName] as? String
        self.rating = dict[kFoursquareVenueRating] as? Double
        self.canonicalURLString = dict[kFoursquareVenueCanonicalURL] as! String
    }
}
