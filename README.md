
The goal is to build a crypto trading app using Flutter, demonstrating knowledge of
modern Flutter practices and state management using GetX.

Main Layout
Sticky Header:
• The app should have a sticky header (App Bar with Tab Bar inside) at the top of the screen.
• The header will include a nav menu with two options:
• Home (default active page).
• Trade.
• The right side of the header will show user info:
• If the user is not logged in, display a log-in button.
• Clicking the log-in button will open a modal with a login form containing
email and password fields.

Home Page
• The Home Page will show a list or table of crypto assets.
• Initially, display 10 items, with the ability to load more on demand by
clicking a button.
• Sorting should be possible by asset name or price.
• Each crypto item will display:
• Price.
• Icon.
• Name.
• A button with a dropdown menu for "Buy" and "Sell" options.

Trade Page
The Trade Page will contain a single form, available only to
logged-in users. It will have the following fields:
Crypto Amount Input Field:
• Dropdown menu to select a crypto asset.
• Allows the user to enter the crypto amount
Fiat Amount Input Field:
• Displays the fiat equivalent (USD) of the entered crypto amount.
Swap Button:
• Allows users to swap the values between the crypto and fiat
fields.

Programming Language:
• The app must be fully developed using Dart with Flutter.
Project Structure:
• Ensure the app follows proper project structure (i.e., separation of
concerns between views, controllers, and services).
State Management:
• Use GetX for state management.
• Properly structure reactive state management for dynamic updates.
Network Calls:
• Utilize Dio or http package for API calls and caching.
• Properly handle pagination, filtering, and errors using GetX GetConnect or
other controllers.
Local Storage:
• Handle authentication state using GetStorage or SharedPreferences.
Authentication:
• Simple local authentication using username/password.
• Handle login, logout, and user state using GetX. API
Resources
Use the following APIs to fetch data:
• Exchange rates: https://exchangerate.host
• Crypto assets: https://www.coinapi.io or https://developers.cryptoapis.io
Design
Custom Design:
• Avoid using third-party UI component libraries. Design a basic system for
buttons, inputs, and text using Flutter's built-in widgets (TextButton,
TextField, Container, etc.).
• Follow Material Design guidelines and ensure responsiveness across
devices.
Task Submission
• The fully functional Flutter project must be uploaded to GitHub, with a clear
README for setup instructions.
• The work must be original and must not involve external assistance.
Provide the GitHub repository link once completed.
Additional Resources
• Flutter Documentation: https://flutter.dev/docs
• GetX Package: https://pub.dev/packages/get
• Dio Package: https://pub.dev/packages/dio
• CoinAPI Docs: https://www.coinapi.io/docs
