
import SwiftUI


struct OverviewView: View {
    
    private let githubProjectLink = URL(string: "https://github.com/AliceVice/Forecastly")
    private let apiLink = URL(string: "https://open-meteo.com/")
    
    var body: some View {
        NavigationStack {
            List {
                projectSection
                
                apiSection
            }
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Overview")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XMarkButton()
                }
            }
        }
    }
}


#Preview {
    OverviewView()
}


// MARK: - Views

extension OverviewView {
    
    private var projectSection: some View {
        Section {
            HStack(alignment: .center, spacing: 16) {
                Image("Forecastly")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("Forecastly")
                    .font(.title)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("This app is a test project that demonstrates the foundations of the developing a mobile weather app using SwiftUI.")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Text("🚀")
                        Text("The MVVM architecture pattern.")
                    }
                    
                    HStack {
                        Text("🔍")
                        Text("Converting information received from a JSON file into the weather information we need.")
                    }
                    
                    HStack {
                        Text("🌐")
                        Text("Asynchronouse data loading, using Swift Concurrency.")
                    }
                    
                    HStack {
                        Text("📍")
                        Text("Getting the user’s location and ensuring they have a smooth UI experience.")
                    }
                    
                    HStack {
                        Text("🧩")
                        Text("Creating custom reusable components")
                    }
                    
                    HStack {
                        Text("🔧")
                        Text("Dependency injection to make the app more maintainable.")
                    }
                    
                    HStack {
                        Text("🔄")
                        Text("Refreshing the data action.")
                    }
                    
                    HStack {
                        Text("📱")
                        Text("Looks great on both iPhone and iPad.")
                    }
                    
                    HStack {
                        Text("✏️")
                        Text("Writing clear and concise comments.")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            if let githubProjectLink {
                Link("Github link to the project", destination: githubProjectLink)
            }
            
        } header: {
            Text("Project")
        }
    }
    
    
    private var apiSection: some View {
        Section {
            HStack(alignment: .center, spacing: 16) {
                Image("OpenMeteo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                
                Text("API")
                    .font(.title)
            }
            
            Text("OpenMeteo free API was used to get the weather data. You can find more information about the API by clicking the link below.")
            
            if let apiLink {
                Link("OpenMeteo API", destination: apiLink)
            }
            
        } header: {
            Text("API")
        }
    }
    
    
}

