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
- In case if you did not allow for location use, you will get redirected to another view that contains the instructions you need to perform to allow it.
  There is a button that will open the settings for the user

<p align="center">
  <img src="https://github.com/user-attachments/assets/87a703ff-d4f6-448d-8bff-b1dc05aa486e" 
       alt="RequestLocation"
       width="250" />
  <img src="https://github.com/user-attachments/assets/c0dfd06f-fce8-457c-bd65-3501e856f0dc" 
       alt="AllowLocationUse"
       width="250" />
  <img src="https://github.com/user-attachments/assets/65ace3ce-7516-46cd-b872-6564cb0e4332" 
       alt="PermissionDenied"
       width="250" />
</p>


- HomeView has a navigation bar with 2 Buttons ("info button" and "expand button") and a sheetView with a detailed forecast.
- You can expand the sheet by using a drag gesture or "expand button" on the top right.
- You can see all the forecast information by scrolling the sheet.

<p align="center">
  <img src="https://github.com/user-attachments/assets/ab509bca-35b1-4b14-9f52-0fc26cfc3a27" 
       alt="HomeViewRecord" 
       width="250" />
</p>

- If you click the "info button", the Overview screen will pop up. It contains links and information about the Project and Api.

<p align="center">
  <img src="https://github.com/user-attachments/assets/6a6bfa84-5157-4001-93b1-52925e00e024" 
       alt="OverviewViewRecord" 
       width="250" />
</p>

### Stack:

- ...
- ... 

# Notes
- @Observable machanism works only if you have iOS 17, so make sure to select minimum deployment target as iOS 17.
- If you launch the App you can see the warning in the console, that says: "CoreSVG has logged an error. Set environment variabe "CORESVG_VERBOSE" to learn more."
  I have used .symbolRenderingMode(.multicolor) on the system images and some of them do not have multicolor mode, so this warning is not crucial.
- May be you have noticed that on the screenshots and videos we can see the bordered bottom of the sheet. That is because i did the screenshots on the simulator. It expanded the image to a square when in reality the simulator screen is a rounded rectangle.
  
