//
//  ios_testing_oct2022App.swift
//  Shared
//
//  Created by Patrick McElroy on 10/5/22.
//

import SwiftUI
import CoreLocation
import Combine
import CoreData

@main
struct ios_testing_oct2022App: App {
    
    @StateObject private var locationService = LocationService()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {

    private let locationManager: CLLocationManager
    private var pendingAuthorizationCompletion: ((Bool) -> Void)?

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        print("init")
        
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
    }

    // MARK: - LocationService

    func start() {
        print("start")
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
            break
        // Handle unauthorized
        case .restricted, .denied, .notDetermined, .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            break

        @unknown default:
            break
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        print("manager")
        switch status {
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringVisits()
            print(locationManager.requestLocation())
        case .notDetermined,
             .authorizedWhenInUse,
             .restricted,
             .denied:
            break
             // Handle unauthorized
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didVisit visit: CLVisit) {
        print("manager did visit")
        let defaults = UserDefaults.standard
        defaults.set("Visit!", forKey: "visit_coord")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("change location")
            if locations.first != nil {
                print(locations)

            }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
    }
}
