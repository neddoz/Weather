//
//  LocationSearchView.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import SwiftUI
import CoreLocation

struct LocationSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LocationSearchResultsViewModel
    @Binding var city: String
    @Binding var cityCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter City", text: $viewModel.cityText)
            Divider()
            Text("Results")
                .font(.title)
            List(viewModel.viewData) { item in
                Button {
                    city = item.title
                    cityCoordinate = item.coordinate
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(item.title)
                    Text(item.subtitle)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading) {

                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
    }
}
