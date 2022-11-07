class Util {
  static int? getInt(dynamic value, [int? defaultValue]) {
    if (value is bool) {
      if (value == true) {
        return 1;
      }
      return 0;
    }
    if (value == null) {
      return defaultValue;
    }
    if (value is int == false) {
      if (value is double) {
        var numStr = value.toString().split(".");
        return int.parse(numStr[0]);
      }
      return int.parse(value);
    }
    return value;
  }

  static double? getDouble(dynamic value, [double? defaultValue]) {
    if (value == null) {
      return defaultValue;
    }
    if (value is double == false) {
      if (value is int) {
        return double.parse(value.toString());
      }
      return double.parse(value);
    }
    return value;
  }

  static String? getString(dynamic value, [String? defaultValue]) {
    if (value==null) {
      return defaultValue;
    }
    return value != null && value != '' ? value.toString() : defaultValue;
  }

  static Map<dynamic, dynamic> getMap(value, [Map<dynamic, dynamic>? defaultValue]) {
    return value != null ? value : defaultValue;
  }
}