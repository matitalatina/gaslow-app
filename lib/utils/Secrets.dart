import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Secrets {
  static Future<String> getString(String property) async {
    List<String> propertyKeys = property.split(".");
    var ymlFile = loadYaml(await rootBundle.loadString('assets/secrets.yml'));
    return propertyKeys.fold(ymlFile, (ymlFile, path) => (ymlFile as dynamic)[path]).toString();
  }

  static Future<String> getServerlessApiKey() async {
    return await Secrets.getString("backend.serverless_api_key");
  }

  static Future<String> getAdmobAppId() async {
    return await Secrets.getString("app.admob_app_id");
  }
}