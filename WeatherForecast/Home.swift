//
//  Home.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel

    let data = (1...6).map { "Item \($0)" }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    init(currentViewModel: HomeViewModel? = nil) {
        self.homeViewModel = HomeViewModel(currentViewMOdel: .init(apiServiceClient: APIClient.shared))
    }
    
    
    var body: some View {
        VStack(spacing: -5) {
            // current weather
            if homeViewModel.state == .success,
               let vm = homeViewModel.currentWeatherViewModel.detailViewModel {
                CurrentWeatherView(viewModel: vm, textFieldBind: $homeViewModel.currentWeatherViewModel.city)
            }
            
            // table view for 5 day forecast
            foreCastView
        }
    }
}

extension Home {

    var foreCastView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                
                GridRow {
                    VStack {
                        Text(AttributedString.init(String(format: "%.1f", 19)))
                            .foregroundColor(.white)
                        Text("Min")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Text(AttributedString.init(String(format: "%.1f", 19)))
                            .foregroundColor(.white)
                        Text("Min")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Text(AttributedString.init(String(format: "%.1f", 19)))
                            .foregroundColor(.white)
                        Text("Min")
                            .foregroundColor(.white)
                    }
                    
                }
                
                GridRow {
                    Text("R 2, C 1")
                    Text("Row 2, Column 2")
                    Text("Row 2, Column 2")
                }

            }

        }.frame(maxHeight: .infinity)
            .background(Color.blue)
    }
}


struct CurrentWeatherView: View {
    var viewModel: CurrentWeatherDetailViewModel
    var textFieldBind: Binding<String>

    init(viewModel: CurrentWeatherDetailViewModel, textFieldBind: Binding<String>) {
        self.viewModel = viewModel
        self.textFieldBind = textFieldBind
    }
    
    var body: some View {
        
        ZStack {
            Image("forest_cloudy")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                TextField("Search Location", text: textFieldBind)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                
                Text(viewModel.temperature)
                    .font(.largeTitle)
            }
            
        }
    }
}

struct StateView: View {
    var body: some View  {
      Text("Fetching data...")
      .foregroundColor(.gray)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(currentViewModel: nil)
    }
}

//https://blog.devgenius.io/stacks-in-swiftui-de8951c3011b
