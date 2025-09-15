# WeatherFlow 🌤️

**A modern Flutter weather application built with BLoC architecture for seamless weather tracking**

## Overview

WeatherFlow is a comprehensive weather application that provides real-time weather information for any city or your current location. Built with Flutter and following clean architecture principles, the app demonstrates professional state management using the BLoC pattern while offering a smooth, responsive user experience.

## Features

- **City Search** - Search weather information for any city worldwide
- **Location-Based Weather** - Get weather data for your current GPS location
- **Temperature Units** - Switch between Celsius and Fahrenheit
- **Theme Toggle** - Light and dark mode support
- **Weather Data Persistence** - Save weather information with API integration
- **Responsive UI** - Clean, intuitive interface with proper loading and error states
- **Real-time Updates** - Live weather data from OpenWeatherMap API

## Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: BLoC Pattern (flutter_bloc)
- **Architecture**: Clean Architecture (Presentation, Application, Domain layers)
- **API**: OpenWeatherMap API
- **Location Services**: GPS integration with location package
- **HTTP Client**: http package for API calls
- **Value Equality**: Equatable for efficient state comparisons

## Installation Guide

### Prerequisites
- Flutter SDK (>=3.5.0)
- Dart SDK
- Android Studio or VS Code
- iOS Simulator or Android Emulator

### Step-by-Step Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/weatherflow.git
   cd weatherflow
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

4. **For release build**
   ```bash
   flutter build apk --release
   ```

## Usage Instructions

### Getting Started
1. Launch the app to see the main navigation screen
2. Choose between two options:
   - **Search by City**: Manually enter a city name
   - **Current Location**: Use GPS to get local weather

### City Search
1. Tap "Search by City"
2. Enter the city name in the search field
3. Tap the search button
4. View detailed weather information
5. Use "Save Weather Data" to store the information

### Current Location Weather
1. Tap "Current Location"
2. Grant location permissions when prompted
3. Tap the floating action button (location icon)
4. View your local weather data

### Settings & Customization
- **Temperature Units**: Switch between Celsius and Fahrenheit
- **Theme**: Toggle between light and dark modes
- **Data Management**: Save weather data for future reference

## Project Structure

### Core Files Overview

#### Entry Point
- `main.dart` - Application entry point with BLoC providers setup

#### Presentation Layer (UI)
- `current_weather.dart` - GPS-based weather display screen
- `search_page.dart` - City search functionality with input validation
- `weather_display.dart` - Reusable weather information widget

#### Application Layer (State Management)
- `weather_bloc.dart` - Main weather state management
- `weather_event.dart` - Weather-related events (search, location, save)
- `weather_state.dart` - Weather states (loading, loaded, error)
- `settings_bloc.dart` - App settings management
- `settings_event.dart` - Settings events (theme, temperature unit)
- `settings_state.dart` - Settings states

#### Domain Layer (Business Logic)
- `weather_repo.dart` - Weather data repository with API integration
- `weather_model.dart` - Weather data model with temperature conversion

#### Configuration
- `pubspec.yaml` - Project dependencies and metadata

### Architecture Patterns

**Clean Architecture Implementation:**
- **Presentation**: UI components and user interactions
- **Application**: BLoC state management and business rules
- **Domain**: Data models and repository interfaces

**BLoC Pattern Benefits:**
- Predictable state management
- Separation of business logic from UI
- Easy testing and debugging
- Reactive programming approach

## API Integration

### Weather Data Retrieval
- **Provider**: OpenWeatherMap API
- **Endpoints**: Current weather by city name and coordinates
- **Data Format**: JSON with automatic parsing to Dart models
- **Error Handling**: Network failures and invalid locations

### Data Operations
- **GET Requests**: Fetch weather data
- **POST Requests**: Save weather information (with mock endpoint)
- **Location Services**: GPS coordinate retrieval with permission handling

## Screenshots / Demo

*Add screenshots of your app here:*
- Main navigation screen
- City search interface
- Weather display with data
- Settings and theme toggle
- Current location weather view

## Future Scope

### Potential Enhancements
- **7-Day Weather Forecast** - Extended weather predictions
- **Weather Maps** - Interactive weather visualization
- **Push Notifications** - Weather alerts and updates
- **Historical Data** - Past weather information and trends
- **Multiple Locations** - Save and track multiple cities
- **Offline Mode** - Cached weather data for offline viewing
- **Weather Widgets** - Home screen weather widgets
- **Social Sharing** - Share weather information with friends

### Technical Improvements
- **Local Database** - SQLite integration for persistent storage
- **Advanced Animations** - Enhanced UI transitions
- **Performance Optimization** - Image caching and lazy loading
- **Accessibility Features** - Screen reader support and larger fonts
- **Internationalization** - Multi-language support

## Troubleshooting

### Common Issues

**Location Permission Denied**
- Go to device settings and enable location permissions for the app
- Ensure location services are enabled on your device

**Network Connection Issues**
- Check internet connectivity
- Verify firewall settings aren't blocking API requests

**City Not Found**
- Try different spelling variations
- Use full city names (e.g., "New York" instead of "NY")
- Check for typos in the search input

**Build Errors**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Performance Tips
- Clear app cache if experiencing slow performance
- Restart the app if weather data seems outdated
- Check device storage space for optimal performance

## Development Notes

### Key Implementation Details
- Temperature conversion from Kelvin (API) to Celsius/Fahrenheit
- Proper state management with loading indicators
- Error boundary implementation for network failures
- Responsive design for different screen sizes

### Testing
- BLoC state testing with mock repositories
- Widget testing for UI components
- Integration testing for complete user flows

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

- **Weather Data**: OpenWeatherMap API
- **Icons**: Flutter Material Design Icons
- **State Management**: BLoC Pattern by Felix Angelov
- **Location Services**: Flutter Location Plugin

---

**Built with ❤️ using Flutter and BLoC Pattern**
