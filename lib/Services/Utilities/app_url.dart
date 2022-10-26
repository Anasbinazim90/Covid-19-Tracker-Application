import 'package:flutter/cupertino.dart';

class AppUrl {
  static String baseurl = 'https://disease.sh/v3/covid-19/';

  // fetch apis

  static String worldstatesApi = baseurl + 'all';
  static String countriesList = baseurl + 'countries';
}
