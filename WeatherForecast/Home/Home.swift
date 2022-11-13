//
//  Home.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import SwiftUI
import CoreLocation

protocol LocationSearchDelegate {
    func search()
    func fetchWeatherFor(city: CLLocationCoordinate2D)
}

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var searchIsPresented = false
    
    var body: some View {
        VStack(spacing: -5) {
            if homeViewModel.state != .success {
                StateView(message:  homeViewModel.stateMessage)
            } else {
                
                if let currentWeatheViewModel = homeViewModel.currentWeatherViewModel,
                   let vm = currentWeatheViewModel.detailViewModel {
                    CurrentWeatherView(viewModel: vm, textFieldBind: $homeViewModel.city, searchDelegate: self)
                    Spacer().frame(height: 5)
                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            GridRow {
                                VStack {
                                    Text("Min")
                                        .foregroundColor(.white)
                                    Text(vm.minTemperature)
                                        .foregroundColor(.white)
                                }
                                
                                VStack {
                                    Text("Current")
                                        .foregroundColor(.white)
                                    Text(vm.temperature)
                                        .foregroundColor(.white)
                                }
                                
                                VStack {
                                    Text("Max")
                                        .foregroundColor(.white)
                                    Text(vm.maxTemperature)
                                        .foregroundColor(.white)
                                }
                            }
                            // table view for 5 day forecast
                            WeeklyforeCastView(viewModel: self.homeViewModel.weeklyViewModel)
                        }
                    }.frame(maxHeight: .infinity)
                        .background(Color.blue)
                }
            }
        }
        .fullScreenCover(isPresented: $searchIsPresented) { LocationSearchView(delegate: self) }
    }
    
    init(currentViewModel: HomeViewModel? = nil) {
        self.homeViewModel = HomeViewModel(currentViewMOdel: .init(apiServiceClient: APIClient.shared), weeklyViewModel: .init(apiServiceClient: APIClient.shared))
    }
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
}

extension Home: LocationSearchDelegate {
    func search() {
        searchIsPresented.toggle()
    }
    
    func fetchWeatherFor(city: CLLocationCoordinate2D) {
        homeViewModel.fetchForeCastFor(location: city)
    }
}

struct WeeklyforeCastView: View {
    
    var body: some View {
        
        if let vms = self.viewModel.detailViewModels {
            ForEach(vms, content: WeeklyDayWeatherRow.init(viewModel:))
        }
    }
    
    init(viewModel: WeeklyForeCastViewModel) {
        self.viewModel = viewModel
    }
    
    private var viewModel: WeeklyForeCastViewModel
}


struct CurrentWeatherView: View {
    var viewModel: CurrentWeatherDetailViewModel
    var textFieldBind: Binding<String>
    var locationSearchDelegate: LocationSearchDelegate?
    
    init(viewModel: CurrentWeatherDetailViewModel, textFieldBind: Binding<String>, searchDelegate: LocationSearchDelegate?) {
        self.viewModel = viewModel
        self.textFieldBind = textFieldBind
        self.locationSearchDelegate = searchDelegate
    }
    
    var body: some View {
        
        ZStack {
            Image(viewModel.icon)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Button {
                    locationSearchDelegate?.search()
                } label: {
                    Text("Search for a Location")
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .background(Color.gray)
                        .border(Color.white, width: 2)
                        
                }
                .frame(width: UIScreen.main.bounds.width * 0.7)

                Text(viewModel.name)
                    .foregroundColor(.white)
                    .font(.largeTitle)

                Text(viewModel.temperature)
                    .font(.title)
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct StateView: View {
    var body: some View  {
        Text(message)
            .foregroundColor(.black)
    }

    init(message: String) {
        self.message = message
    }

    private let message: String
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(currentViewModel: nil)
    }
}

struct WeeklyDayWeatherRow: View {
    private let viewModel: WeeklyForeCastDetailViewModel
    
    init(viewModel: WeeklyForeCastDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GridRow{
            Text(viewModel.day)
                .foregroundColor(.white)
            Text(viewModel.weatherListing.weather.first?.main ?? "")
                .foregroundColor(.white)
            Text(viewModel.maxTemperature)
                .foregroundColor(.white)
        }
    }
}
