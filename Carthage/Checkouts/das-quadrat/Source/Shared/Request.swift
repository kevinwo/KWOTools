//
//  Request.swift
//  Quadrat
//
//  Created by Constantine Fry on 17/11/14.
//  Copyright (c) 2014 Constantine Fry. All rights reserved.
//

import Foundation

class Request {
    
    let parameters: Parameters?
    
    /** Endpoint path. */
    let path: String
    
    /** Can be POST or GET. */
    let HTTPMethod: String
    
    /** Session wise parameters from configuration. */
    let sessionParameters: Parameters
    
    /** Should be like this "https://api.foursquare.com/v2". Specified in `Configuration` */
    let baseURL: URL
    
    /** The timeout interval in seconds. */
    var timeoutInterval: TimeInterval = 60
    
    /** Optionally pass in a preformatted query string to append after all other params are added **/
    var preformattedQueryString: String?
    
    init(baseURL: URL, path: String, parameters: Parameters?,
        sessionParameters: Parameters, HTTPMethod: String, preformattedQueryString: String? = nil) {
            
            self.baseURL = baseURL
            self.parameters = parameters
            self.sessionParameters = sessionParameters
            self.HTTPMethod = HTTPMethod
            self.path = path
            self.preformattedQueryString = preformattedQueryString
    }
    
    func URLRequest() -> URLRequest {
        // if multi,
        var allParameters = self.sessionParameters
        if let parameters = self.parameters {
            allParameters.addEntriesFrom(dictionary: parameters)
        }
        let URL = self.baseURL.appendingPathComponent(self.path)
        let requestURL = Parameter.buildURL(URL, parameters: allParameters,
            preformattedQueryString: preformattedQueryString)
        var request = Foundation.URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod
        return request
    }
}
