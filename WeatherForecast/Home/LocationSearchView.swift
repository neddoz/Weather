//
//  LocationSearchView.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LocationSearchResultsViewModel
    var delegate: LocationSearchDelegate?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter City", text: $viewModel.cityText)
            Divider()
            Text("Results")
                .font(.title)
            SwiftUI.List(viewModel.viewData) { item in
                Button {
                    delegate?.fetchWeatherFor(city: item.coordinate)
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
    
    init(delegate: LocationSearchDelegate, viewModel: LocationSearchResultsViewModel = .init()){
        self.delegate = delegate
        self.viewModel = viewModel
    }
}
