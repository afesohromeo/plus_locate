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
  String get decode => 'Décoder';

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
  String get actionDecode => 'Décoder le code';

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
  String get confirmDeleteTitle => 'Supprimer le code';

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
}
