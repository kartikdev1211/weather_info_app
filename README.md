# Weather App

A simple weather application built using Flutter that fetches and displays current weather information for a given city. The app utilizes the OpenWeatherMap API to fetch weather data.

## Features

- Home screen with a search bar to enter a city name.
- Weather details screen to display the weather information including:
  - City name
  - Current temperature (in Celsius)
  - Weather condition (e.g., cloudy, sunny, rainy)
  - An icon representing the weather condition
  - Humidity percentage
  - Wind speed
- Loading indicator while fetching data.
- Proper error handling for API requests with user-friendly error messages.
- State management using the `Provider` package.
- Basic responsive design for both mobile and tablet devices.
- "Refresh" button to fetch updated weather data.
- Data persistence to save the last searched city.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your local machine.
- An API key from [OpenWeatherMap](https://openweathermap.org/api).

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/weather_app.git
    cd weather_app
    ```

2. Install the dependencies:
    ```sh
    flutter pub get
    ```

3. Replace `'YOUR_API_KEY'` in `lib/services/weather_service.dart` with your actual OpenWeatherMap API key:
    ```dart
    static const String apiKey = 'YOUR_API_KEY';
    ```

4. Run the app:
    ```sh
    flutter run
    ```

## Folder Structure
weather_app/
|- lib/
|- models/
|- weather.dart # Weather model
|- providers/
|- weather_provider.dart # Weather provider for state management
|- screens/
|- home_screen.dart # Home screen with search functionality
|- weather_details_screen.dart # Weather details screen
|- services/
|- weather_service.dart # Service to fetch weather data from OpenWeatherMap API
|- main.dart # Main file to run the app
|- pubspec.yaml # Project dependencies

## Dependencies

- `http`: ^0.13.4
- `provider`: ^6.0.3
- `shared_preferences`: ^2.0.13
