class ApiUrls {
  ApiUrls._();

  // Change base URL
  static const bool change = false;

  // Base URL
  static const baseUrlProd = "http://candidat.aptiotalent.com/api";
  static const baseUrlTest = "https://onyva.sodalite-consulting.com/api";

  // Pour obtenir la bonne base URL
  static String get baseUrl => change ? baseUrlProd : baseUrlTest;

  // Authentification
  static String get postLogin => "$baseUrl/login";
  static String get postRegister => "$baseUrl/register";
  static String get postOtp => "$baseUrl/otp";
  static String get postReset => "$baseUrl/reset";
  static String get postUpdate => "$baseUrl/update/";
  static String get deleteDelete => "$baseUrl/delete/";

    // Categories
  static String get getCategory => "$baseUrl/type";
  static String get getCity => "$baseUrl/commune";

    // Aventures
  static String get postCreateAdventure => "$baseUrl/aventure/creer";
  static String get getListCategory => "$baseUrl/aventures/par-categorie";
  static String get postJointAdventure => "$baseUrl/aventures/rejoindre";
  static String get getListAdventureByCategory => "$baseUrl/aventures?categorie=";

    // Abonnements
  static String get postPayment => "$baseUrl/abonnement/initier-paiement";
  static String get postConfirmPayment => "$baseUrl/abonnement/confirmer-paiement";
  static String get getCheckAbonnement => "$baseUrl/abonnement/statut?user=";

    // Adventure by User
  static String get getAdventureCreateByUser => "$baseUrl/aventure/utilisateur/creer?utilisateur=";
  static String get getAdventureJoinByUser => "$baseUrl/aventure/utilisateur/participer?utilisateur=";
  static String get postCancelAdventureByUser => "$baseUrl/aventure/utilisateur/cancel";

    // Terms & Conditions
  static String get getAbout => "$baseUrl/about";
  static String get getPolicy => "$baseUrl/politique";
  static String get getCondition => "$baseUrl/condition";

    // Token FCM
  static String get postSaveToken => "$baseUrl/token";
  static String get postSendNotification => "$baseUrl/sendnotification";

}