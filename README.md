# Crypto Trading App

## Overview

This is a Flutter-based crypto trading application that allows users to trade cryptocurrencies, view
market data, and manage their accounts. The app demonstrates practical knowledge of modern Flutter
practices, including state management with GetX.

## Features

- **Sticky Header**: Includes a persistent App Bar with Tab Bar for navigation.
- **Home Page**:
    - Displays a list of crypto assets with loading capabilities.
    - Supports sorting by asset name and price.
    - Each item includes:
        - Asset price
        - Asset icon
        - Asset name
        - Dropdown menu for "Buy" and "Sell" options
- **Trade Page**:
    - Accessible only to logged-in users.
    - Includes input fields for crypto amount and fiat equivalent (USD).
    - Swap button to exchange values between crypto and fiat inputs.
- **Authentication**:
    - Simple login form for user authentication with email and password.
    - User state management using GetX and local storage.

## Technologies Used

- Flutter (Dart)
- GetX for state management
- Dio for API calls
- GetStorage for local storage
- Responsive design following Material Design guidelines
- Custom UI components using Flutter's built-in widgets

## API Resources

- **Exchange Rates**: [ExchangeRate Host](https://exchangerate.host)
- **Crypto Assets**: [CoinAPI](https://www.coinapi.io)
  or [CryptoAPI](https://developers.cryptoapis.io)

## Project Structure

The app follows a clean architecture with the following structure:

lib/
├── controllers/ # GetX Controllers
├── models/ # Data Models
├── services/ # API Handling
├── views/ # UI Pages
│ ├── home_screen.dart
│ ├── trade_screen.dart
│ └── login_modal.dart
└── main.dart # Entry Point

## Setup Instructions

To run this project on your local machine, follow these steps:

1. **Clone the repository**:
   bash
   git clone https://github.com/shikiwiki/aab_crypto_app.git
   cd aab_crypto_app
2. **Install Flutter** (if you haven’t already):

   Follow the instructions from
   the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

3. **Install Dependencies**:

   Ensure you have the latest version of the Dart SDK, then run:

bash
flutter pub get

4. **Run the App**:

   Connect your device or start an emulator, then execute:

bash
flutter run

## Technologies Used in `pubspec.yaml`

The project uses the following dependencies:

yaml
name: aab_crypto_app
description: "A new Flutter project."

publish_to: 'none'

version: 1.0.0+1

environment:
sdk: ^3.5.3
dependencies:
flutter:
sdk: flutter
get: ^4.6.6
dio: ^5.7.0
json_annotation: ^4.9.0
json_serializable: ^6.8.0
get_storage: ^2.1.1
crypto: ^3.0.5

dev_dependencies:
flutter_test:
sdk: flutter
flutter_lints: ^4.0.0

flutter:
uses-material-design: true
generate: true

## Contribution

This project is a solo effort. However, any contributions or suggestions are welcome. Please open an
issue for any changes or features you would like to propose.

## Acknowledgments

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Package](https://pub.dev/packages/get)
- [Dio Package](https://pub.dev/packages/dio)
- [CoinAPI Documentation](https://www.coinapi.io/docs)
