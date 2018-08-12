import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Secrets {
  static Future<String> getString(String property) async {
    List<String> propertyKeys = property.split(".");
    var ymlFile = loadYaml(await rootBundle.loadString('assets/secrets.yml'));
    return propertyKeys.fold(ymlFile, (ymlFile, path) => ymlFile[path]).toString();
  }

  static Future<String> getGoogleApiKey() async {
    if (Platform.isAndroid) {
      return await Secrets.getString("google_maps.ios_api_key");
    }
    else {
      return await Secrets.getString("google_maps.android_api_key");
    }
  }
}