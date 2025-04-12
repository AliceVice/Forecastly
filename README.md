
<h1>
  Forecastly
  <img src="https://github.com/user-attachments/assets/fede5c8f-2a26-4cee-8b03-d2d078473471" width="30" height="30" style="vertical-align: middle;" />
</h1>

Hello everyone 👋. Forecastly is a test project showcasing a SwiftUI weather application.

### Functionality
- The app displays today's weather and a 7-day forecast, showing current temperature, conditions, and location along with daily high/low forecasts.
- The weather is fetched based on the user's current location. Location permission is requested at launch, and all authorization states are handled with appropriate feedback.
- The forecast is downloaded using Swift Concurrency (async/await).
- The app uses the MVVM pattern for clear separation of concerns

<br /><br />


# OpenMeteo API 🌤
Forecastly uses the [OpenMeteo API](https://open-meteo.com/) to fetch real-time weather data and forecasts. It provides detailed weather information such as current conditions, hourly updates, and 7-day forecasts, all in an easy-to-use JSON format — **no API key required**.


<br /><br />

# Implementation 🛠️

### Stack:

- **SwiftUI**: For building the app’s user interface.
- **MVVM Architecture**: For clear separation of concerns and maintainable code.
- **Swift Concurrency (async/await)**: For handling asynchronous network calls and data processing.
- **@Observable** / **Swift’s New Observation Model**: For state management across the app.
- **Core Location**: For obtaining the user’s current location and reverse‑geocoding.
- **Open‑Meteo API**: To fetch real‑time weather data (daily, hourly, and current conditions).  

### Project Structure:
<img width="250" alt="Screenshot 2025-03-23 at 12 29 46 PM" src="https://github.com/user-attachments/assets/bb5e779c-3d53-489c-ad95-4ab04e3f16db" />

### Screens:
- When the user opens the app, he needs to grant location access.
- If the user has not enabled location access, he will be redirected to a view with instructions on how to do so; this view also includes a button to open the settings.

<p align="center">
  <img src="https://github.com/user-attachments/assets/87a703ff-d4f6-448d-8bff-b1dc05aa486e" 
       alt="RequestLocation"
       width="250" />
  <img src="https://github.com/user-attachments/assets/c0dfd06f-fce8-457c-bd65-3501e856f0dc" 
       alt="AllowLocationUse"
       width="250" />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/65ace3ce-7516-46cd-b872-6564cb0e4332" 
       alt="PermissionDenied"
       width="250" />
</p>

- An error message appears in case if there was an error while fetching the forecast.

<p align="center">
  <img src="https://github.com/user-attachments/assets/df75ab1f-5a67-4607-b3a0-3cae411fd718" 
       alt="ErrorScreen"
       width="250" />
</p>

- The HomeView has a navigation bar with two buttons (“info button” and “expand button”) and a sheet view displaying a detailed forecast.
- You can expand the sheet either by using a drag gesture or by tapping the “expand button” in the top right corner.
- You can view all of the forecast information by scrolling through the sheet.

<p align="center">
  <img src="https://github.com/user-attachments/assets/ab509bca-35b1-4b14-9f52-0fc26cfc3a27" 
       alt="HomeViewRecord" 
       width="250" />
</p>

- Tapping the “info button” brings up the Overview screen, which contains links and information about the project and API.
<p align="center">
  <img src="https://github.com/user-attachments/assets/ab5d4704-6bf7-4b8e-9919-fda4f8ff6490" 
       alt="OverviewViewRecord" 
       width="250" />

</p>


<br /><br />
  
# Notes 🗒️
- The `@Observable` mechanism works only with iOS 17, so ensure that the minimum deployment target is set to iOS 17.
- When you launch the app, you might see the following warning in the console:  
  `"CoreSVG has logged an error. Set environment variable 'CORESVG_VERBOSE' to learn more."`  
  This warning is not critical because I have applied `.symbolRenderingMode(.multicolor)` on system images, but not all of them support multicolor mode.

  
