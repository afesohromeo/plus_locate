// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PlusLocate';

  @override
  String get count => 'Count';

  @override
  String get home => 'Home';

  @override
  String get generate => 'Generate';

  @override
  String get mapView => 'Map';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get labelPlusCode => 'Plus Code';

  @override
  String get labelLatitude => 'Latitude';

  @override
  String get labelLongitude => 'Longitude';

  @override
  String get labelAddress => 'Address';

  @override
  String get labelLocality => 'Locality';

  @override
  String get labelLabel => 'Label';

  @override
  String get actionGenerate => 'Generate Code';

  @override
  String get actionSave => 'Save';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionCopy => 'Copy';

  @override
  String get actionShare => 'Share';

  @override
  String get actionLocateMe => 'Locate Me';

  @override
  String get msgCodeCopied => 'Code copied to clipboard';

  @override
  String get msgCodeSaved => 'Code saved successfully';

  @override
  String get msgCodeDeleted => 'Code deleted';

  @override
  String get msgNoResults => 'No results found';

  @override
  String get msgEnterPlusCode => 'Enter a Plus Code';

  @override
  String get msgEnterCoordinates => 'Enter coordinates or use your location';

  @override
  String get errorLocationPermission => 'Location permission denied';

  @override
  String get errorLocationService => 'Location services are disabled';

  @override
  String get errorInvalidPlusCode => 'Invalid Plus Code format';

  @override
  String get errorInvalidCoordinates => 'Invalid coordinates';

  @override
  String get errorNetworkUnavailable => 'Network unavailable';

  @override
  String get errorTimeout => 'Request timed out';

  @override
  String get confirmDeleteTitle => 'Delete saved location';

  @override
  String get confirmDeleteMessage =>
      'Are you sure you want to delete this saved code?';

  @override
  String get refresh => 'Refresh';

  @override
  String get search => 'Search';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get loading => 'Loading...';

  @override
  String get noData => 'No data';

  @override
  String get operationError => 'An error occurred';

  @override
  String get searchCountry => 'Search country';

  @override
  String get validateMobile1 => 'Invalid Mobile Number';

  @override
  String get tel => 'Tel';

  @override
  String get validateMobile2 => 'Phone number must start with 6.';

  @override
  String get authenticationRequired => 'Authentication Required';

  @override
  String get proceed => 'Proceed';

  @override
  String get searchPlacesOrCodes => 'Search for places or Plus Codes';

  @override
  String get searchResult => 'Search Result';

  @override
  String get viewOnMap => 'View on Map';

  @override
  String get searchInitialPrompt =>
      'Search for an address or Plus Code to see details here';

  @override
  String get currentLocation => 'CURRENT LOCATION';

  @override
  String get unknownLocation => 'Unknown Location';

  @override
  String get selectLocationOnMap => 'Select a location on the map';

  @override
  String get navigate => 'Navigate';

  @override
  String get saved => 'Saved';

  @override
  String get msgLocationShared => 'Location shared';

  @override
  String shareLocationText(
      String plusCode, String lat, String lng, String address) {
    return 'Check out this location: $plusCode ($lat, $lng) - $address';
  }

  @override
  String get msgLocationSaved => 'Location saved to history';

  @override
  String get layers => 'Layers';

  @override
  String get satellite => 'Satellite';

  @override
  String get terrain => 'Terrain';

  @override
  String get savedLocations => 'Saved locations';
}
