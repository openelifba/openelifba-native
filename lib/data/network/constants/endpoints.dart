class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://gateway.dev.wordiam.com";
  static const String auth = "$baseUrl/auth/api";
  static const String openElifba = "$baseUrl/open-elifba/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

}
