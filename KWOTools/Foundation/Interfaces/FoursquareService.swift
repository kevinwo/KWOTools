//
//  FoursquareService.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import QuadratTouch

open class FoursquareService {

    let session: Session

    public init(clientID: String, clientSecret: String) {
        let client = Client(clientID: clientID,
                            clientSecret: clientSecret,
                            redirectURL: "")
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        self.session = Session.sharedSession()
    }

    open func fetchVenue(_ venueId: String, success: @escaping (_ response: [String: AnyObject]) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let task = self.session.venues.get(venueId) { (result) in
            if let error = result.error {
                failure(error)
            } else {
                if let response = result.response {
                    success(response)
                } else {
                    failure((NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data was returned for this venue"])) as Error)
                }
            }
        }

        task.start()
    }
}
