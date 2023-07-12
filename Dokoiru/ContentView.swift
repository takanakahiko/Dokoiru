//
//  ContentView.swift
//  Dokoiru
//
//  Created by takanakahiko on 2023/07/09.
//

import SwiftUI
import MapKit

class MyLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location = CLLocation()
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
   }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let last = locations.last {
            location = last
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var myLocationManager = MyLocationManager()
    
    @State var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    @State var isPresented = true
    
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode)
        .ignoresSafeArea()
        .sheet(isPresented: $isPresented) {
            Form {
                Section {
                    LabeledContent("latitude", value: String(myLocationManager.location.coordinate.latitude))
                    LabeledContent("longitude", value: String(myLocationManager.location.coordinate.longitude))
                } header: {
                    Text("My Location")
                }
            }
            .ignoresSafeArea(.all)
            .presentationDetents([
                .height(130),
                .medium,
                .large
            ])
            .interactiveDismissDisabled()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
