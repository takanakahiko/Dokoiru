//
//  ContentView.swift
//  Dokoiru
//
//  Created by takanakahiko on 2023/07/09.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    userTrackingMode: $trackingMode)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
