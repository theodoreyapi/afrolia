class ApiUrls {
  ApiUrls._();

  // Change base URL
  static const bool change = false;

  // Base URL
  static const baseUrlProd = "http://candidat.aptiotalent.com/api";
  static const baseUrlTest = "http://afrolia.sodalite-consulting.com/api";

  // Pour obtenir la bonne base URL
  static String get baseUrl => change ? baseUrlProd : baseUrlTest;

  // Authentification
  static String get postLogin => "$baseUrl/login";

  static String get postRegister => "$baseUrl/register";

  static String get postOtp => "$baseUrl/otp";

  static String get postReset => "$baseUrl/reset";

  static String get postUpdate => "$baseUrl/update/";

  static String get deleteDelete => "$baseUrl/delete/";

  // Help & Support
  static String get getHelp => "$baseUrl/help";

  static String get getSecurity => "$baseUrl/security";

  // Salons Complets
  static String get postUpdateInfoBasic => "$baseUrl/updateinfobasic/";

  static String get postUpdatepresentation => "$baseUrl/updatepresentation/";

  static String get getFirstPresentation => "$baseUrl/presentation/";

  static String get getListSpecialite => "$baseUrl/specialites";

  static String get getListLanguage => "$baseUrl/langues";

  static String get getListAssoSpecialiste => "$baseUrl/associationspecialite/";

  static String get getListAssoLanguage => "$baseUrl/associationlangue/";

  static String get postAssociationSpecialiste =>
      "$baseUrl/hair/specialites/associer";

  static String get postAssociationLanguage => "$baseUrl/hair/langues/associer";

  static String get getListDisponibility => "$baseUrl/disponibilites/";

  static String get postSaveDisponibility => "$baseUrl/disponibilites";

  static String get getListJoursHeures => "$baseUrl/jours-heures";

  static String get getListServices => "$baseUrl/hair/services/";

  static String get postSaveService => "$baseUrl/hair/services";

  static String get putUpdateService => "$baseUrl/services/";

  static String get deleteDeleteService => "$baseUrl/services/";

  static String get getFirstSociaux => "$baseUrl/hair/sociaux/";

  static String get postSaveSociaux => "$baseUrl/hair/sociaux";

  static String get getListGallery => "$baseUrl/hair/gallery/";

  static String get postSaveGallery => "$baseUrl/hair/gallery";

  static String get putUpdateGallery => "$baseUrl/gallery/";

  static String get deleteDeleteGallery => "$baseUrl/gallery/";

  // Reservation
  static String get postReservation => "$baseUrl/reservations";

  static String get getListReservation => "$baseUrl/reservations/user/";

  static String get putUpdateReservation => "$baseUrl/reservations/";

  static String get deleteDeleteReservation => "$baseUrl/reservations/";

  // Paiement
  static String get postPaiement => "$baseUrl/paiements";

  static String get getListPaiement => "$baseUrl/paiements/user/";

  static String get putUpdatePaiement => "$baseUrl/paiements/";

  static String get deleteDeletePaiement => "$baseUrl/paiements/";

  // Gains
  static String get postGains => "$baseUrl/gains-coiffeuses";

  static String get getListGains => "$baseUrl/gains-coiffeuses/user/";

  static String get putUpdateGains => "$baseUrl/gains-coiffeuses/";

  static String get deleteDeleteGains => "$baseUrl/gains-coiffeuses/";

  // Avis
  static String get postAvis => "$baseUrl/avis";

  static String get getListAvis => "$baseUrl/avis/coiffeuse/";

  static String get putUpdateAvis => "$baseUrl/avis/";

  static String get deleteDeleteAvis => "$baseUrl/avis/";

  // Favorite
  static String get postFavoris => "$baseUrl/favoris/ajouter";

  static String get getListFavoris => "$baseUrl/favoris/client/";

  static String get postVerifierFavoris => "$baseUrl/verifier/";

  static String get deleteDeleteFavoris => "$baseUrl/favoris/supprimer";

  // Dashboard
  static String get postDashboard => "$baseUrl/dashboard/";
}
