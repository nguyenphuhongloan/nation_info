import '../constants/apiUrls.dart';

class Country {
  final String countryName;
  final int population;
  final double areaInSqKm;
  final String capital;
  final String countryCode;
  const Country({
    required this.countryName,
    required this.population,
    required this.areaInSqKm,
    required this.capital,
    required this.countryCode,
  });
  factory Country.fromJSON(Map<String, dynamic> json) {
    return Country(
        countryName: json["countryName"],
        population: int.parse(json["population"]),
        areaInSqKm: double.parse(json["areaInSqKm"]),
        capital: json["capital"],
        countryCode: json["countryCode"]);
  }
  String getFlagImageUrl() {
    String nameCode = countryCode.toLowerCase();
    return "$flagImageBaseUrl$nameCode.gif";
  }
  String getMapImageUrl() {
    return "$mapImageBaseUrl$countryCode.png";
  }
}
