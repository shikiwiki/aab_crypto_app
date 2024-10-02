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
- GetX for state management and navigation
- Dio for API calls
- GetStorage for local storage
- JSON Annotation & JSON Serializable for handling data
- Dartz for efficial API responses processing
- Responsive design following Material Design guidelines
- Custom UI components using Flutter's built-in widgets

## API Resources

- **Crypto Assets**: [CoinAPI](https://www.coinapi.io)

## Project Structure

The app follows MVVM architectural pattern.
Every feature contains three layers:
* view - stands for presentation,
* view_model - stands for business logic,
* services - stands for data.

Example of home feature below:

features

├── home

│ ├── models

│ │ ├── asset_model.dart

│ │ └── option.dart

│ └── services

│ │ └── home_service.dart

│ └── view

│ │ └── widgets

│ │ │ └── asset_widget.dart

│ │ └── home_screen.dart

│ └── view_model

│ │ └── home_controller.dart

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
   Ensure you have at least 3.0.0 version of the Dart SDK, then run:
   bash
   flutter pub get

4. **Run the App**:

   Connect your device or start an emulator, then execute:

   bash
   flutter run

## Contribution

This project is a solo effort. However, any contributions or suggestions are welcome. Please open an
issue for any changes or features you would like to propose.

## Acknowledgments

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Package](https://pub.dev/packages/get)
- [Dio Package](https://pub.dev/packages/dio)
- [CoinAPI Documentation](https://www.coinapi.io)
