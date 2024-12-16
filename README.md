
# WeatherApp

WeatherApp is a Swift-based iOS application that allows users to search for weather details by city. It displays temperature, weather conditions, humidity, UV index, and "feels like" temperature. The app persists the last searched city and loads its weather data on subsequent app launches.

---

## Features

- # Search for Weather: Users can search for any city and view its weather details.
- # Detailed Weather Information:
  - Temperature
  - Weather condition with icon
  - Humidity
  - UV index
  - Feels like temperature
- # Persistent Storage:
- The app remembers the last searched city and reloads its data on app launch.
- # Interactive Navigation:
- Tap the city name to navigate to Apple Maps.

---

## Setup Instructions

### Requirements
- macOS
- Xcode 14 or later
- Swift 5.0 or later
- WeatherAPI account with a valid API key

---

### Getting Started

1. # Clone the Repository
   ```bash
   git clone https://github.com/sadenesmith88/WeatherApp.git
   cd WeatherApp
   ```

2. # Open the Project
   - Launch Xcode.
   - Open the `WeatherApp.xcodeproj` file.

3. # Configure the API Key
   - Sign up for a free account on [WeatherAPI](https://www.weatherapi.com/).
   - Copy your API key from the WeatherAPI dashboard.
   - Add the API key to the `WeatherService.swift` file:
     ```swift
     private let apiKey = "YOUR_API_KEY"
     ```

4. # Run the App
   - Connect an iOS simulator or device.
   - Click the **Run** button in Xcode or press `Cmd + R`.

---

## How to Use

1. # Search for a City
   - Enter the city name in the search bar.
   - Tap the magnifying glass icon or press return to fetch weather data.

2. # View Weather Details
   - The app displays temperature, weather condition (with an icon), humidity, UV index, and feels-like temperature.

3. # Save and Reload City
   - The last searched city is saved and automatically loaded when you reopen the app.

4. # Navigate to Maps
   - Tap the city name to open its location in Apple Maps.

---


## Architecture
The app follows the **Model-View-ViewModel (MVVM)** architecture:

- # Model: Handles the data layer and API responses.
- # View : Displays the user interface and binds to the ViewModel.
- # ViewModel: Manages the business logic and acts as a bridge between the Model and the View.

---

## Dependencies
The app uses built-in Swift and SwiftUI libraries with no external dependencies.

---

## Future Enhancements

- Add support for multiple saved cities.
- Improve error handling and show more detailed messages for invalid inputs or network issues.
- Provide hourly and weekly weather forecasts.



