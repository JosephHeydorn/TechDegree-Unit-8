//
//  LocationManager.swift
//  Unit 8 SwiftUI Version
//
//  Created by Joseph Heydorn on 1/4/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import CoreLocation

var locationHolder = ""

class LocationHandler: CLLocationManager {
    private let locationManager = CLLocationManager()
    
    func requestLocationMainAuth() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocationOnce() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("\(location.coordinate.latitude)\(location.coordinate.longitude)")
            let locations = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            locations.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                print(city + ", " + country)  // San Francisco, United States
                locationHolder = "\(city), \(country)"
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
