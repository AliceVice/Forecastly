# Forecastly
Hello everyone 👋. I found an awesome test task on the Internet and decided to complete it 🚀.
I hope this will help someone 😄.

# The requirements
- Build an app that displays today's weather and a 7-day forecast, showing current temperature and conditions, and location along with daily high/low forecasts.
- Fetch weather based on the user's current location, request permission at launch, and handle all authorization states with appropriate feedback.
- Use Swift Concurrency (async/await) for all asynchronous operations.
- Build the UI with SwiftUI using the MVVM pattern for clear separation of concerns.
- Design and layout are open-ended, as long as the functional requirements are met.

# Implementation

### Screens:

- When you open an App, you need to allow for location use.
  
![RequestLocation](https://github.com/user-attachments/assets/4748a810-9a70-4bec-a064-72e650f86189)
![AllowForLocationUse](https://github.com/user-attachments/assets/2829d441-6270-45b4-8abc-eb967835720c)

- In case if you did not allow for location use, you will get redirected to another view that contains the instructions you need to perform to allow it.
  There is a button that will open the settings for the user
  
![PermissionDenied](https://github.com/user-attachments/assets/e27af6dd-2001-47de-bd5c-0a44b127fa3f)

- HomeView has a navigation bar with 2 Buttons ("info button" and "expand button") and a sheetView with a detail forecast.

![HomeView](https://github.com/user-attachments/assets/9cb7bc1e-4f99-46fa-89f5-a39fabe1939e)

- You can expand the sheet by using a drag gesture of "expand button" on the top right.

![HomeViewExpanded](https://github.com/user-attachments/assets/ae753571-c2cb-4c31-8907-443a2aef12bf)

- You can see an entire forecast information by scrolling the sheet

![HomeViewRecord](https://github.com/user-attachments/assets/ab509bca-35b1-4b14-9f52-0fc26cfc3a27)

- Overview screen contains information about the Project and Api

![OverviewViewRecord](https://github.com/user-attachments/assets/6a6bfa84-5157-4001-93b1-52925e00e024)




# Notes
- @Observable machanism works only if you have iOS 17, so make sure to select minimum deployment target as iOS 17.
- If you launch the App you can see the warning in the console, that says: "CoreSVG has logged an error. Set environment variabe "CORESVG_VERBOSE" to learn more."
  I have used .symbolRenderingMode(.multicolor) on the system images and some of them do not have multicolor mode, so this warning is not crucial.
  
