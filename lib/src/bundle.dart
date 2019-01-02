import 'tools/string_base64.dart';

class Bundle {
  String name;
  String headerColor;
  String headerBackgroundColor;
  String bordersColor;
  String bodyBackgroundColor;

  List<BundleSpriteSetData> spriteSets;

  Bundle(
      {this.name,
      this.headerColor,
      this.headerBackgroundColor,
      this.bordersColor,
      this.bodyBackgroundColor,
      this.spriteSets});

  static Bundle fromMap(Map source) => Bundle(
        name: source["name"],
        headerColor: source["header_color"],
        headerBackgroundColor: source["header_background_color"],
        bordersColor: source["borders_color"],
        bodyBackgroundColor: source["body_background_color"],
        spriteSets: (source["sprite_sets"] as List)
            .cast<Map>()
            .map(BundleSpriteSetData.fromMap)
            .toList(growable: false),
      );
}

class BundleSpriteSetData {
  String name;
  String displayName;
  String url;
  String color;

  BundleSpriteSetData({this.name, this.displayName, this.url, this.color});

  static BundleSpriteSetData fromMap(Map source) => BundleSpriteSetData(
        name: source["name"],
        displayName: source["display_name"],
        url: source["url"],
        color: source["color"],
      );
}

const stringBase64Decoder = StringBase64Decoder();
String normalizeBundleIdentifier(String identifier) {
  if (identifier.startsWith(RegExp("https?:\\/\\/"))) return identifier;
  try {
    final ret = stringBase64Decoder.decode(identifier);
    if (!ret.startsWith(RegExp("https?:\\/\\/"))) throw FormatException();
    return ret;
  } on FormatException {
    throw FormatException("Malformed bundle identifier");
  }
}