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

public typealias KWOFindUserLocationSuccessBlock = ((_ location: CLLocation) -> Void)?
public typealias KWOFindUserLocationFailureBlock = ((_ error: NSError) -> Void)?

open class KWOLocationManager: NSObject {

    open var currentLocation: CLLocation?
    open var currentPlacemark: CLPlacemark?
    fileprivate var findUserLocationSuccessBlock: KWOFindUserLocationSuccessBlock?
    fileprivate var findUserLocationFailureBlock: KWOFindUserLocationFailureBlock?
    fileprivate var restrictedError: NSError {
        get {
            let appName = kKWOAppBundleName ?? "the application"
            return NSError.kwo_error(withTitle: "Location Services Restricted", message: "Enable Location Services in Settings > General > Restrictions to allow \(appName) to determine your current location.", domain: kKWOErrorDomain, code: KWOLocationErrorCodeDenied)
        }
    }
    fileprivate var deniedError: NSError {
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

    open func findMyLocation(_ success: KWOFindUserLocationSuccessBlock? = nil, failure: KWOFindUserLocationFailureBlock? = nil) {
        self.findUserLocationSuccessBlock = success
        self.findUserLocationFailureBlock = failure
        self.findLocation(withAuthorizationStatus: CLLocationManager.authorizationStatus())
    }

    open func currentLocationDistance(_ latitude: Double, longitude: Double) -> CLLocationDistance? {
        let loc = CLLocation(latitude: latitude, longitude: longitude)

        if let location = self.currentLocation {
            return loc.distance(from: location)
        }

        return nil
    }

    open func hasCurrentLocation() -> Bool {
        return self.currentLocation != nil
    }

    open func reverseGeocodeCurrentLocation() {
        if let location = self.currentLocation {
            self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
                if error == nil {
                    self.currentPlacemark = placemarks!.first!
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kKWOLocationManagerDidUpdatePlacemarkNotification), object: nil)
                } else {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kKWOLocationManagerDidFailUpdatePlacemarkWithErrorNotification), object: nil)
                }
            }
        }
    }

    fileprivate func findLocation(withAuthorizationStatus status: CLAuthorizationStatus) {
        var error: NSError?

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.findUserLocation()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            error = self.restrictedError
        case .denied:
            error = self.deniedError
        }

        if let anError = error, let failureBlock = self.findUserLocationFailureBlock {
            failureBlock!(anError)
            self.findUserLocationFailureBlock = nil
        }
    }
}

extension KWOLocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        self.currentLocation = locations.first!
        NotificationCenter.default.post(name: Notification.Name(rawValue: kKWOLocationManagerDidUpdateLocationNotification), object: nil)

        if let completion = self.findUserLocationSuccessBlock {
            completion!(self.currentLocation!)
            self.findUserLocationSuccessBlock = nil
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        NotificationCenter.default.post(name: Notification.Name(rawValue: kKWOLocationManagerDidFailUpdateLocationWithErrorNotification), object: nil)

        if let completion = self.findUserLocationFailureBlock {
            completion!(error as NSError)
            self.findUserLocationFailureBlock = nil
        }
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.findLocation(withAuthorizationStatus: status)
    }

    // MARK: Private interface

    fileprivate func findUserLocation() {
        #if !os(tvOS)
        self.locationManager.startUpdatingLocation()
        #endif
    }
}
