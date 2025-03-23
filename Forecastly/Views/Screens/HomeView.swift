
import SwiftUI


struct HomeView: View {
    
    @Environment(LocationManager.self) var locationManager
    @State private var viewModel: HomeViewModel
    
    @State private var sheetState: SheetState = .partiallyExpanded
    @State private var isPresented: Bool = false
    
    @State private var showSettingsSheet: Bool = false
    
    public init(forecastDataManager: ForecastDataManager) {
        self._viewModel = State(wrappedValue: HomeViewModel(forecastDataManager: forecastDataManager))
    }
    
    var body: some View {
                
        ZStack(alignment: .bottom) {
        
            if case .loading = viewModel.loadingState {

                loadingView
                
            } else if case .loaded = viewModel.loadingState {
                
                if sheetState == .partiallyExpanded {
                    // A refresh data empty view
                    refreshableEmptyView
                }
                
                // Navigation with 2 buttons and short forecast info
                navigationBar

                // A view in the middle with a short forecast info
                currentWeatherHeader

                // Custom sheet with full forecast data
                SheetView(sheetState: $sheetState) {
                    ScrollView(.vertical) {
                        VStack {
                            hourlyForecast
                            
                            dailyForecast
                            
                            detailsForecast
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
            } else if case .error(let description) = viewModel.loadingState {
                SomethingWentWrongView(errorDescription: description) {
                    Task {
                        await tryFetchForecast()
                    }
                }
            }
        }
        .background(
            backgroundImage
        )
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showSettingsSheet) {
            OverviewView()
        }
        .task {
            await tryFetchForecast()
        }
    }
    
    
    private func tryFetchForecast() async {
        
        do {
            guard let userLocation = locationManager.userLocation  else {
                viewModel.loadingState = .error(description: "There was an error getting your location!")
                return
            }
            
            try await viewModel.getForecast(for: userLocation)
            print("FORECAST DATA DOWNLOADED")
        } catch {
            viewModel.loadingState = .error(description: error.localizedDescription)
        }
        
    }
    
}


#Preview {
    HomeView(
        forecastDataManager: ProductionForecastDataManager()
    )
    .environment(LocationManager.shared)
}


// MARK: - Views

extension HomeView {
    
    private var loadingView: some View {
        VStack {
            Spacer()
            
            ProgressView()
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
    
    private var backgroundImage: some View {
        GeometryReader { geo in
            Image("WeatherBackground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width)
                .ignoresSafeArea()
        }
    }
    
    private var refreshableEmptyView: some View {
        VStack {
            ScrollView {
                Color.clear
            }
            .refreshable {
                await tryFetchForecast()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private var navigationBar: some View {
        VStack(spacing: 0) {
            HStack {
                CircleButton(imageName: "info")
                    .onTapGesture {
                        showSettingsSheet = true
                    }
                
                Spacer()
                
                if sheetState == .expanded {
                    Text("\(viewModel.forecast.currentTemp.temp, specifier: "%.1f")°C | \(locationManager.cityName)")
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                CircleButton(imageName: "chevron.down")
                    .rotationEffect(
                        Angle(degrees: sheetState == .expanded ? 0 : 180)
                    )
                    .onTapGesture {
                        sheetState.switchToNextState()
                    }
            }
            .frame(height: 80)
            .padding(.top, 4)
            .padding(.horizontal)
            
            Spacer()
        }
        .animation(.easeInOut, value: sheetState)
    }
    
    private var currentWeatherHeader: some View {
        VStack(spacing: 0) {
            if sheetState == .partiallyExpanded {
                VStack(alignment: .center) {
                    
                    Image(systemName: viewModel.forecast.currentTemp.imageName)
                        .font(Font.system(size: 72))
                        .symbolRenderingMode(.multicolor)
                    
                    Text("\(locationManager.cityName)")
                        .font(.title)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.7)

                    Text("\(viewModel.forecast.currentTemp.temp, specifier: "%.1f")°C")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .padding(.top, UIScreen.height * 0.2)
                
                Spacer()
            }
        }
        .animation(.easeInOut, value: sheetState)
    }
    
    private var hourlyForecast: some View {
        VStack(spacing: 0) {
            Text("Hourly")
                .foregroundStyle(.secondary)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.forecast.next24Hours, id: \.hour) { hourForecast in
                        HourlyColumn(
                            hour: hourForecast.hour,
                            imageName: hourForecast.imageName,
                            temperature: Int(hourForecast.temp)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var dailyForecast: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal)
            
            Text("Daily")
                .foregroundStyle(.secondary)
            
            ForEach(viewModel.forecast.next7Days, id: \.day) { dayForecast in
                DailtyRow(
                    day: dayForecast.day,
                    imageName: dayForecast.imageName,
                    minTemp: Int(dayForecast.minTemp),
                    maxTemp: Int(dayForecast.maxTemp),
                    temperatures: dayForecast.temperatures
                )
                .padding()
            }
        }
    }
    
    private var detailsForecast: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal)
            
            Text("Current Conditions")
                .foregroundStyle(.secondary)
            
            Grid(horizontalSpacing: 8, verticalSpacing: 8) {
                GridRow {
                    CardView(cardName: "Humidity",
                             cardImageName: "humidity.fill",
                             value: "\(viewModel.forecast.currentHumidity.value)",
                             description: "\(viewModel.forecast.currentHumidity.category)")
                    
                    CardView(cardName: "Feels Like",
                             cardImageName: nil,
                             value: "\(viewModel.forecast.current.apparentTemperature) °C",
                             description: "Actual: \(viewModel.forecast.current.temperature2M) °C")
                }
                
                GridRow {
                    CardView(cardName: "Precipitation",
                             cardImageName: "drop.fill",
                             value: nil,
                             description: "\(Int(viewModel.forecast.current.precipitation)) mm")
                    
                    CardView(cardName: "UV Index",
                             cardImageName: "field.of.view.ultrawide",
                             value: "\(viewModel.forecast.todaysUVIndex.value)",
                             description: viewModel.forecast.todaysUVIndex.category)
                }
                GridRow {
                    CardView(cardName: "Wind Speed",
                             cardImageName: "wind",
                             value: "wind: \(viewModel.forecast.current.windSpeed10M) m/s \ngusts: \(viewModel.forecast.current.windGusts10M) m/s",
                             description: "Direction \(viewModel.forecast.current.windDirection10M)°")
                    .gridCellColumns(2)
                }
            }
            .padding()
        }
        
    }
    
}


