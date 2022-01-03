/// This class provides the constants for the various API endpoints.
///
class Endpoints {
  Endpoints._();

  // Add the urls and parameters of the endpoints used by the application below
  // URL recette
  static const String AUTH_URL = "https://auth.mesdepanneurs.wtf/api/";

  //URL DE déploiement
  //  static const String AUTH_URL = "https://md-auth.mesdepanneurs.fr/api/";

  // URL recette
  static const String CORE_URL = "https://api-order.mesdepanneurs.wtf/api/v1/";

  //URL DE déploiement
  // static const String CORE_URL = "https://api-order.mesdepanneurs.fr/api/v1/";
  static const String PAYMENT_URL =
      "https://api-order.mesdepanneurs.wtf/api/v1/payment/";
  static const String URL = "https://api-order.mesdepanneurs.wtf/api/";
  static const String URL_PERSON =
      "https://api-person.mesdepanneurs.wtf/api/v1";
}
