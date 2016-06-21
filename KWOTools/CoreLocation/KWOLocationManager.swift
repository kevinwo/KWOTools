//
//  KWOLocationManager.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/14/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import CoreLocation

public let kKWOLocationManagerDidUpdateLocationNotification = "kKWOLocationManagerDidUpdateLocationNotification"
public let kKWOLocationManagerDidUpdatePlacemarkNotification = "kKWOLocationManagerDidUpdatePlacemarkNotification"
public let kKWOLocationManagerDidFailUpdateLocationWithErrorNotification = "kKWOLocationManagerDidFailUpdateLocationWithErrorNotification"
public let kKWOLocationManagerDidFailUpdatePlacemarkWithErrorNotification = "kKWOLocationManagerDidFailUpdatePlacemarkWithErrorNotification"

public let KWOLocationErrorCodeDenied: Int = 1000

public typealias KWOFindUserLocationSuccessBlock = ((location: CLLocation) -> Void)?
public typealias KWOFindUserLocationFailureBlock = ((error: NSError) -> Void)?

public class KWOLocationManager: NSObject {

    public var currentLocation: CLLocation?
    public var currentPlacemark: CLPlacemark?
    private var findUserLocationSuccessBlock: KWOFindUserLocationSuccessBlock?
    private var findUserLocationFailureBlock: KWOFindUserLocationFailureBlock?
    private var restrictedError: NSError {
        get {
            let appName = kKWOAppBundleName ?? "the application"
            return NSError.kwo_error(withTitle: "Location Services Restricted", message: "Enable Location Services in Settings > General > Restrictions to allow \(appName) to determine your current location.", domain: kKWOErrorDomain, code: KWOLocationErrorCodeDenied)
        }
    }
    private var deniedError: NSError {
        get {
            let appName = kKWOAppBundleName ?? "the application"
            return NSError.kwo_error(withTitle: "Location Services Off", message: "Turn on Location Services in Settings > Privacy to allow \(appName) to determine your current location.", domain: kKWOErrorDomain, code: KWOLocationErrorCodeDenied)
        }
    }

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    let geocoder = CLGeocoder()

    public func findMyLocation(success: KWOFindUserLocationSuccessBlock? = nil, failure: KWOFindUserLocationFailureBlock? = nil) {
        self.findUserLocationSuccessBlock = success
        self.findUserLocationFailureBlock = failure
        self.findLocation(withAuthorizationStatus: CLLocationManager.authorizationStatus())
    }

    public func currentLocationDistance(latitude: Double, longitude: Double) -> CLLocationDistance? {
        let loc = CLLocation(latitude: latitude, longitude: longitude)

        if let location = self.currentLocation {
            return loc.distanceFromLocation(location)
        }

        return nil
    }

    public func hasCurrentLocation() -> Bool {
        return self.currentLocation != nil
    }

    public func reverseGeocodeCurrentLocation() {
        if let location = self.currentLocation {
            self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
                if error == nil {
                    self.currentPlacemark = placemarks!.first!
                    NSNotificationCenter.defaultCenter().postNotificationName(kKWOLocationManagerDidUpdatePlacemarkNotification, object: nil)
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName(kKWOLocationManagerDidFailUpdatePlacemarkWithErrorNotification, object: nil)
                }
            }
        }
    }

    private func findLocation(withAuthorizationStatus status: CLAuthorizationStatus) {
        var error: NSError?

        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            self.findUserLocation()
        case .NotDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .Restricted:
            error = self.restrictedError
        case .Denied:
            error = self.deniedError
        }

        if let anError = error, failureBlock = self.findUserLocationFailureBlock {
            failureBlock!(error: anError)
            self.findUserLocationFailureBlock = nil
        }
    }
}

extension KWOLocationManager: CLLocationManagerDelegate {
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        self.currentLocation = locations.first!
        NSNotificationCenter.defaultCenter().postNotificationName(kKWOLocationManagerDidUpdateLocationNotification, object: nil)

        if let completion = self.findUserLocationSuccessBlock {
            completion!(location: self.currentLocation!)
            self.findUserLocationSuccessBlock = nil
        }
    }

    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSNotificationCenter.defaultCenter().postNotificationName(kKWOLocationManagerDidFailUpdateLocationWithErrorNotification, object: nil)

        if let completion = self.findUserLocationFailureBlock {
            completion!(error: error)
            self.findUserLocationFailureBlock = nil
        }
    }

    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.findLocation(withAuthorizationStatus: status)
    }

    // MARK: Private interface

    private func findUserLocation() {
        self.locationManager.startUpdatingLocation()
    }
}
