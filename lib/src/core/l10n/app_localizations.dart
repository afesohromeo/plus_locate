import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Application title displayed in app bar and system
  ///
  /// In en, this message translates to:
  /// **'PlusLocate'**
  String get appTitle;

  /// Counter label (legacy — keep for home page)
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Generate Plus Code page title
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// Map view page title
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapView;

  /// Saved codes history page title
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for Plus Code input/display field
  ///
  /// In en, this message translates to:
  /// **'Plus Code'**
  String get labelPlusCode;

  /// Label for latitude field
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get labelLatitude;

  /// Label for longitude field
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get labelLongitude;

  /// Label for address field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get labelAddress;

  /// Label for locality/city field
  ///
  /// In en, this message translates to:
  /// **'Locality'**
  String get labelLocality;

  /// Label for user-defined label/note field
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get labelLabel;

  /// Button text to generate a Plus Code from coordinates
  ///
  /// In en, this message translates to:
  /// **'Generate Code'**
  String get actionGenerate;

  /// Button text to save a Plus Code to history
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// Button text to delete a saved code
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// Button text to copy to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionCopy;

  /// Button text to share a Plus Code
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionShare;

  /// Button text to get current device location
  ///
  /// In en, this message translates to:
  /// **'Locate Me'**
  String get actionLocateMe;

  /// Snackbar message when Plus Code is copied
  ///
  /// In en, this message translates to:
  /// **'Code copied to clipboard'**
  String get msgCodeCopied;

  /// Snackbar message when a code is saved to history
  ///
  /// In en, this message translates to:
  /// **'Code saved successfully'**
  String get msgCodeSaved;

  /// Snackbar message when a code is deleted from history
  ///
  /// In en, this message translates to:
  /// **'Code deleted'**
  String get msgCodeDeleted;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get msgNoResults;

  /// Hint text for Plus Code input field
  ///
  /// In en, this message translates to:
  /// **'Enter a Plus Code'**
  String get msgEnterPlusCode;

  /// Hint text for coordinate input
  ///
  /// In en, this message translates to:
  /// **'Enter coordinates or use your location'**
  String get msgEnterCoordinates;

  /// Error when device location permission is denied
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get errorLocationPermission;

  /// Error when device location services are turned off
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled'**
  String get errorLocationService;

  /// Validation error for malformed Plus Code input
  ///
  /// In en, this message translates to:
  /// **'Invalid Plus Code format'**
  String get errorInvalidPlusCode;

  /// Validation error for invalid lat/lng values
  ///
  /// In en, this message translates to:
  /// **'Invalid coordinates'**
  String get errorInvalidCoordinates;

  /// Error when no internet connection is available
  ///
  /// In en, this message translates to:
  /// **'Network unavailable'**
  String get errorNetworkUnavailable;

  /// Error when API request times out
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get errorTimeout;

  /// Title of delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete saved location'**
  String get confirmDeleteTitle;

  /// Body text of delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this saved code?'**
  String get confirmDeleteMessage;

  /// Button text to refresh content
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Button text for OK action
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Affirmative button text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Negative button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Generic loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// Generic operation error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get operationError;

  /// Placeholder text for country search field
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// Phone number validation text 1
  ///
  /// In en, this message translates to:
  /// **'Invalid Mobile Number'**
  String get validateMobile1;

  /// Label for telephone field
  ///
  /// In en, this message translates to:
  /// **'Tel'**
  String get tel;

  /// Phone number validation text 2
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 6.'**
  String get validateMobile2;

  /// Dialog title when user needs to authenticate
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get authenticationRequired;

  /// Button text to proceed with an action
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Placeholder for search pill
  ///
  /// In en, this message translates to:
  /// **'Search for places or Plus Codes'**
  String get searchPlacesOrCodes;

  /// Header title for the search result card
  ///
  /// In en, this message translates to:
  /// **'Search Result'**
  String get searchResult;

  /// Button/tooltip to focus the searched location on the map
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get viewOnMap;

  /// Placeholder shown on the Search tab before any search is performed
  ///
  /// In en, this message translates to:
  /// **'Search for an address or Plus Code to see details here'**
  String get searchInitialPrompt;

  /// Header for current location card
  ///
  /// In en, this message translates to:
  /// **'CURRENT LOCATION'**
  String get currentLocation;

  /// Fallback text for unknown location
  ///
  /// In en, this message translates to:
  /// **'Unknown Location'**
  String get unknownLocation;

  /// Text shown when no location is selected
  ///
  /// In en, this message translates to:
  /// **'Select a location on the map'**
  String get selectLocationOnMap;

  /// Button text to start navigation
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// Button text indicating an item is saved
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// Snackbar message when location is shared
  ///
  /// In en, this message translates to:
  /// **'Location shared'**
  String get msgLocationShared;

  /// Text format used when sharing a location
  ///
  /// In en, this message translates to:
  /// **'Check out this location: {plusCode} ({lat}, {lng}) - {address}'**
  String shareLocationText(
      String plusCode, String lat, String lng, String address);

  /// Snackbar message when location is saved to history
  ///
  /// In en, this message translates to:
  /// **'Location saved to history'**
  String get msgLocationSaved;

  /// Layers button label
  ///
  /// In en, this message translates to:
  /// **'Layers'**
  String get layers;

  /// Satellite map type label
  ///
  /// In en, this message translates to:
  /// **'Satellite'**
  String get satellite;

  /// Terrain map type label
  ///
  /// In en, this message translates to:
  /// **'Terrain'**
  String get terrain;

  /// Terrain map type label
  ///
  /// In en, this message translates to:
  /// **'Saved locations'**
  String get savedLocations;

  /// AppBar title showing number of selected items in selection mode
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// Button to select all saved locations
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// Title of the multi-delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete saved locations'**
  String get confirmDeleteMultipleTitle;

  /// Body text of the multi-delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} saved locations?'**
  String confirmDeleteMultipleMessage(int count);

  /// Snackbar message when multiple codes are deleted from history
  ///
  /// In en, this message translates to:
  /// **'{count} locations deleted'**
  String msgCodesDeleted(int count);

  /// Error message shown when deleting multiple selected codes fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete the selected locations'**
  String get errorDeletingSelectedCodes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
