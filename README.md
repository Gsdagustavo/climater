

# 🌦️ Climater

**Climater** is a modern and intuitive weather app built with Flutter. It provides current weather information based on your location, using data from the OpenWeatherMap API. The app features a clean interface, dark/light theme support, and leverages robust packages like `provider` and `shared_preferences` for state management and persistence.

## 🚀 Features

- 📍 Fetches weather based on your **current location**
- 🌤 Displays real-time weather data using the **OpenWeatherMap API**
- 🌙 Supports **light and dark modes**, with persistent theme preference
- ⚙️ Uses **Provider** for state management
- 🔐 Secures your API key using **dotenv** and a `.env` file

## 🛠 Built With

- **Flutter** – UI toolkit for building natively compiled apps
- **OpenWeatherMap API** – For fetching weather data
- **geolocator** – To get the device’s location
- **geocoding** – To convert coordinates into human-readable addresses
- **provider** – For state management
- **shared_preferences** – To persist theme settings
- **flutter_dotenv** – To load environment variables from a `.env` file

## 📦 Dependencies

Include the following in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  geolocator: ^10.0.0
  geocoding: ^2.0.0
  shared_preferences: ^2.0.0
  http: ^0.13.0
  flutter_dotenv: ^5.0.2
````

*(Check pub.dev for the latest versions)*

## 🗝️ API Key Setup

1. Create a `.env` file in the root of your project:

   ```env
   API_KEY=your_api_key_here
   ```

2. Load the `.env` in your `main.dart`:

   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';

   void main() async {
     await dotenv.load();
     runApp(const MyApp());
   }
   ```

3. Access the key using:

   ```dart
   final apiKey = dotenv.env['API_KEY'];
   ```

4. Make sure `.env` is listed in your `.gitignore` to keep it out of version control:

   ```gitignore
   .env
   ```

## 🖼 Screenshots

*(Add screenshots here if available)*

## 🔧 Getting Started

```bash
git clone https://github.com/your-username/climater.git
cd climater
flutter pub get
```

* Create and configure the `.env` file as shown above.
* Ensure location permissions are configured for both Android and iOS.
* Run the app:

  ```bash
  flutter run
  ```

## 🤝 Contributing

Contributions are welcome! Feel free to fork the repository and open a pull request.

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

Made with ❤️ using Flutter.
