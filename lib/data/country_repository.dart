import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nation_info/models/country.dart';
import 'package:nation_info/constants/apiUrls.dart';

Future<List<Country>> getAllCountry() async {
  final response = await http.get(Uri.parse(countryInfoUrl));
  List<Country> countryList = [];
  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    print(json);
    //List? tmp = json != null ? List.from(json['geonames']) : null;

    countryList = (json['geonames'] as List).map((e) => Country.fromJSON(e)).toList();
  }
  return countryList;
}
