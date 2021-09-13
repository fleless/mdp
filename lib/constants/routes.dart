import 'package:interpolation/interpolation.dart';

/// This class provides the routes used by the application.
///
class Routes {
  Routes._();

  final Interpolation interpolation = Interpolation();

  // Add your routes below
  static const String login = '/login';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String calendar = '/calendar';
  static const String mesInterventions = '/interventions';
  static const String photoView = '/photoView';
  static const String detailCommande = '/detailCommande';
  static const String calendrierPriseRDV = '/calendrierPriseRDV';
  static const String ajouterRDV = '/ajouterRDV';
  static const String modifierRdv = '/modifierRDV';
  static const String redactionDevis = '/redactionDevis';
  static const String profil = '/profil';
  static const String notifications = '/notifications';
  static const String creationDesignation = '/creationDesignation';
  static const String signatureArtisan = '/signatureArtisan';
  static const String presentationDevis = '/presentationDevis';
  static const String envoyerDevisMail = '/envoyerDevisMail';
  static const String signatureClient = '/signatureClient';
  static const String ajouterRealisationRDV = '/ajouterRealisationRDV';
  static const String calendrierRealisationRDV = "/calendrierRealisationRDV";
  static const String documentTypeSelector = "/documentTypeSelector";

  // Utility method used to build a dynamic route with params.
  // Example: Routes.buildRouteWithParams('/users/{id}, {'id': 1}); would generate '/users/1'
  String buildRouteWithParams(
      final String route, final Map<String, dynamic> params) {
    return interpolation.eval(route, params);
  }
}
