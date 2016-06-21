//
//  FoursquareService.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import QuadratTouch

public class FoursquareService {

    let session: Session

    public init(clientID: String, clientSecret: String) {
        let client = Client(clientID: clientID,
                            clientSecret: clientSecret,
                            redirectURL: "")
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        self.session = Session.sharedSession()
    }

    public func fetchVenue(venueId: String, success: (response: [String: AnyObject]) -> Void, failure: (error: NSError) -> Void) {
        let task = self.session.venues.get(venueId) { (result) in
            if let error = result.error {
                failure(error: error)
            } else {
                if let response = result.response {
                    success(response: response)
                } else {
                    failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data was returned for this venue"]))
                }
            }
        }

        task.start()
    }
}
