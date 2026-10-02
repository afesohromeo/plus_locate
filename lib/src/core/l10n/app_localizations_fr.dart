// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PlusLocate';

  @override
  String get count => 'Compteur';

  @override
  String get home => 'Accueil';

  @override
  String get generate => 'Générer';

  @override
  String get mapView => 'Carte';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get labelPlusCode => 'Plus Code';

  @override
  String get labelLatitude => 'Latitude';

  @override
  String get labelLongitude => 'Longitude';

  @override
  String get labelAddress => 'Adresse';

  @override
  String get labelLocality => 'Localité';

  @override
  String get labelLabel => 'Libellé';

  @override
  String get actionGenerate => 'Générer le code';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionDelete => 'Supprimer';

  @override
  String get actionCopy => 'Copier';

  @override
  String get actionShare => 'Partager';

  @override
  String get actionLocateMe => 'Me localiser';

  @override
  String get msgCodeCopied => 'Code copié dans le presse-papiers';

  @override
  String get msgCodeSaved => 'Code enregistré avec succès';

  @override
  String get msgCodeDeleted => 'Code supprimé';

  @override
  String get msgNoResults => 'Aucun résultat trouvé';

  @override
  String get msgEnterPlusCode => 'Saisissez un Plus Code';

  @override
  String get msgEnterCoordinates =>
      'Saisissez des coordonnées ou utilisez votre position';

  @override
  String get errorLocationPermission => 'Autorisation de localisation refusée';

  @override
  String get errorLocationService =>
      'Les services de localisation sont désactivés';

  @override
  String get errorInvalidPlusCode => 'Format de Plus Code invalide';

  @override
  String get errorInvalidCoordinates => 'Coordonnées invalides';

  @override
  String get errorNetworkUnavailable => 'Réseau indisponible';

  @override
  String get errorTimeout => 'La requête a expiré';

  @override
  String get confirmDeleteTitle => 'Supprimer l\'emplacement enregistré';

  @override
  String get confirmDeleteMessage =>
      'Êtes-vous sûr de vouloir supprimer ce code enregistré ?';

  @override
  String get refresh => 'Rafraîchir';

  @override
  String get search => 'Recherche';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get loading => 'Chargement...';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get operationError => 'Une erreur est survenue';

  @override
  String get searchCountry => 'Rechercher un pays';

  @override
  String get validateMobile1 => 'Numéro de téléphone invalide';

  @override
  String get tel => 'Tél';

  @override
  String get validateMobile2 => 'Le numéro de téléphone doit commencer par 6.';

  @override
  String get authenticationRequired => 'Authentification Requise';

  @override
  String get proceed => 'Procéder';

  @override
  String get searchPlacesOrCodes => 'Rechercher des lieux ou des Plus Codes';

  @override
  String get searchResult => 'Résultat de recherche';

  @override
  String get viewOnMap => 'Voir sur la carte';

  @override
  String get searchInitialPrompt =>
      'Recherchez une adresse ou un Plus Code pour voir les détails ici';

  @override
  String get currentLocation => 'POSITION ACTUELLE';

  @override
  String get unknownLocation => 'Position inconnue';

  @override
  String get selectLocationOnMap => 'Sélectionnez un emplacement sur la carte';

  @override
  String get navigate => 'Naviguer';

  @override
  String get saved => 'Enregistré';

  @override
  String get msgLocationShared => 'Emplacement partagé';

  @override
  String shareLocationText(
      String plusCode, String lat, String lng, String address) {
    return 'Découvrez cet emplacement : $plusCode ($lat, $lng) - $address';
  }

  @override
  String get msgLocationSaved => 'Emplacement sauvegardé dans l\'historique';

  @override
  String get layers => 'Couches';

  @override
  String get satellite => 'Satellite';

  @override
  String get terrain => 'Terrain';

  @override
  String get savedLocations => 'Emplacements enregistrés';

  @override
  String selectedCount(int count) {
    return '$count sélectionné(s)';
  }

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get confirmDeleteMultipleTitle =>
      'Supprimer les emplacements enregistrés';

  @override
  String confirmDeleteMultipleMessage(int count) {
    return 'Êtes-vous sûr de vouloir supprimer $count emplacements enregistrés ?';
  }

  @override
  String msgCodesDeleted(int count) {
    return '$count emplacements supprimés';
  }

  @override
  String get errorDeletingSelectedCodes =>
      'Échec de la suppression des emplacements sélectionnés';

  @override
  String get onboardingHeadline => 'Trouvez votre place';

  @override
  String get onboardingHeadlineAccent => 'Partout.';

  @override
  String get onboardingTagline =>
      'Découvrez des codes Plus précis pour n\'importe quel endroit sur Terre, même sans adresse. Naviguez dans le monde avec une précision architecturale.';

  @override
  String get onboardingPrecise => 'Précis à 3 mètres';

  @override
  String get onboardingFeatureGlobal => 'Couverture mondiale';

  @override
  String get onboardingFeatureOffline => 'Accès hors ligne';

  @override
  String get onboardingFeatureShare => 'Partage facile';

  @override
  String get getStarted => 'Commencer';

  @override
  String get errorPlacesUnavailable =>
      'Les suggestions sont indisponibles pour le moment. Appuyez sur rechercher pour chercher l\'adresse directement.';

  @override
  String get errorPlaceDetails =>
      'Impossible de charger les détails de ce lieu. Veuillez réessayer.';

  @override
  String get errorSearchFailed => 'La recherche a échoué. Veuillez réessayer.';

  @override
  String get errorShortPlusCodeNeedsLocality =>
      'Ajoutez une ville après un Plus Code court, par ex. 9G8F+6W Douala.';

  @override
  String get errorShortPlusCodeLocalityNotFound =>
      'Impossible de trouver la ville de ce Plus Code.';

  @override
  String get poweredByGoogle => 'Powered by Google';

  @override
  String get errorLocationServiceDisabled =>
      'La localisation est désactivée. Activez-la pour centrer la carte sur votre position.';

  @override
  String get errorLocationPermissionDenied =>
      'PlusLocate n\'est pas autorisé à utiliser votre position. Autorisez-la dans les paramètres de l\'application pour centrer la carte sur votre position.';

  @override
  String get errorLocationUnavailable =>
      'Impossible d\'obtenir votre position actuelle. Veuillez réessayer.';

  @override
  String get showDetails => 'Afficher les détails';

  @override
  String get hideDetails => 'Masquer les détails';
}
