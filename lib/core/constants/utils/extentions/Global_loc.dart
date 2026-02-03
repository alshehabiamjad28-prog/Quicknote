
import 'package:flutter/cupertino.dart';
import '../../../../l10n/arb/app_localizations.dart';

class GlobalLoc {
  static AppLocalizations? _instance;

  static AppLocalizations get instance {
    assert(_instance != null, 'AppLocalizations not initialized');
    return _instance!;
  }

  static void init(BuildContext context) {
    _instance = AppLocalizations.of(context);
  }
}