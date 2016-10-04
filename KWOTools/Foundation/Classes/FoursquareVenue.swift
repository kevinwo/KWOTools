//
//  FoursquareVenue.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/10/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

open class FoursquareVenue {

    open var id: String!
    open var name: String!
    open var rating: Double?
    open var ratingString: String? {
        get {
            if let value = rating {
                return String(format: "%.1f", value)
            }
            
            return nil
        }
    }
    open var canonicalURLString: String!
    open var canonicalURL: URL {
        get {
            return URL(string: self.canonicalURLString)!
        }
    }
    open var isFault: Bool {
        get {
            return canonicalURLString == nil
        }
    }

    fileprivate let kFoursquareVenueID = "id"
    fileprivate let kFoursquareVenueName = "name"
    fileprivate let kFoursquareVenueRating = "rating"
    fileprivate let kFoursquareVenueCanonicalURL = "canonicalUrl"

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
