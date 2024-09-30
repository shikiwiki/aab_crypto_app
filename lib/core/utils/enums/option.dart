import 'package:aab_crypto_app/core/localizations/app_strings.dart';

enum Option {
  buy,
  sell,
}

extension OptionExtension on Option {
  String get name {
    switch (this) {
      case Option.buy:
        return AppStrings.buy;
      case Option.sell:
        return AppStrings.sell;
    }
  }
}