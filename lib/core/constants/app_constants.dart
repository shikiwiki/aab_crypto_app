import 'package:flutter/material.dart';

abstract class AppConstants {
  static const title = 'Crypto App';
  static const apiKey = '6beab760-8ff2-4463-a0eb-821bffda152c';
  static const apiKeyHeader = 'X-CoinAPI-Key';
  static const baseUrl = 'https://rest.coinapi.io';
  static const assetsEndpoint = '$baseUrl/v1/assets';
  static const iconsEndpoint = '$baseUrl/v1/assets/icons/16';
  static const home = 'Home';
  static const trade = 'Trade';
  static const empty = '';
  static const dot = '.';
  static const isLoggedIn = 'isLoggedIn';
  static const loggedOut = 'Logout';
  static const loggedOutMessage = 'Logout';
  static reversed(String value) => '${value}Reversed';
  static const noItemsFound = 'No items found';
  static const fetchAssetsExceptionMessage = 'Failed to load assets';
  static const fetchIconsExceptionMessage = 'Failed to load icons';
  static const assetId = 'asset_id';
  static const url = 'url';
  static const more = 'More';
  static const name = 'name';
  static const nameReversed = 'nameReversed';
  static const price = 'price';
  static const priceReversed = 'priceReversed';
  static const cryptoAmount = 'Crypto Amount';
  static const zeroString = '0';
  static const fiatAmount = 'Fiat Amount (USD)';
  static const swap = 'Swap';
  static const noAccessMessage = 'Please log in to access this page.';
  static const logIn = 'Log In';
  static const email = 'Email';
  static const password = 'Password';
  static const logInMessage = 'You logged in successfully!';
  static const error = 'Error';
  static const errorMessage = 'Please, input correct data.';
  static const contentTypeHeader = 'Content-Type';
  static const contentType = 'application/json';
  static const select = 'Select';
  static const buy = 'Buy';
  static const sell = 'Sell';
  static const sortBy = 'Sort by';
  static const selectAsset = 'Select asset';

  static const primaryColor = Color(0xFF8A1538);
  static const secondaryColor = Colors.white;

  static const num zero = 0;
  static const int one = 1;
  static const int two = 2;
  static const int ten = 10;
  static const int codeOk = 200;

  static const int initialTabIndex = 0;
  static const int tabsCount = 2;
  static const double toolBarHeight = 30;

  static const double paddingMedium = 24;

  static const double separatorSize = 10;
}
