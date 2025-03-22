
import SwiftUI


struct OverviewView: View {
    
    private let githubDeveloperLink = URL(string: "https://github.com/AliceVice")
    private let githubProjectLink = URL(string: "https://github.com/AliceVice")
    private let apiLink = URL(string: "https://open-meteo.com/")
    
    var body: some View {
        NavigationStack {
            List {
                teskSection
                
                apiSection
                
                developerSection
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
    
    private var teskSection: some View {
        Section {
            HStack(alignment: .center, spacing: 16) {
                Text("☁️")
                    .font(.system(size: 90))
                
                Text("Forecastly")
                    .font(.title)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("This App was incredibly fun to create. It contains a lot of cool features and mechanisms:")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Text("🚀")
                        Text("Using the MVVM architecture pattern.")
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
                        Text("A little bit of dependency injection to make the app more maintainable.")
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
            Text("Task")
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
                .font(.headline)
            
            if let apiLink {
                Link("OpenMeteo API", destination: apiLink)
            }
            
        } header: {
            Text("API")
        }
    }
    
    
    private var developerSection: some View {
        Section {
            HStack(alignment: .center, spacing: 16) {
                Text("🥳")
                    .font(.system(size: 90))
                
                Text("Hello everybody!")
                    .font(.title)
            }
            
            Text("This task was fun and I really enjoyed creating it! Feel free to use the app's code as you wish. You can find the code on my github page. Happy coding! 🔥")
                .font(.headline)
            
            if let githubDeveloperLink {
                Link("My github", destination: githubDeveloperLink)
            }
            
        } header: {
            Text("Developer")
        }
    }
    
}

