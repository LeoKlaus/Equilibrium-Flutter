import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class PreferenceKeys {
  static final hubUrl = "hub_url";
  static final invertImages = "invert_images";
}

class EquilibriumSettings {
  EquilibriumSettings(StreamingSharedPreferences preferences)
      : invertImages = preferences.getBool(PreferenceKeys.invertImages, defaultValue: false),
        hubUrl = preferences.getString(PreferenceKeys.hubUrl, defaultValue: "null");

  final Preference<bool> invertImages;
  final Preference<String> hubUrl;
}