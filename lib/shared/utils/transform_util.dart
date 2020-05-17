class TransformUtil {
  static String views(String count) {
    int value = int.parse(count);
    double valueParse;

    if (value / 1000 < 1) {
      return "$count visualizações";
    } else if (value / 1000 >= 1 && value / 1000000 < 1) {
      valueParse = value / 1000;
      return "${valueParse.toStringAsFixed(1)} mil visualizações";
    } else {
      valueParse = value / 1000000;
      return "${valueParse.toStringAsFixed(1)} mi visualizações";
    }
  }

  static String dateParse(String date) {
    DateTime value = DateTime.parse(date);
    Duration subtract = DateTime.now().difference(value);
    int hours = subtract.inHours;
    int parse;

    if (hours <= 24) {
      if (hours == 1) {
        return "${subtract.inHours} hora";
      } else {
        return "${subtract.inHours} horas";
      }
    } else if (hours > 24 && hours <= 168) {
      return "${subtract.inDays} dias";
    } else if (hours > 168 && hours <= 672) {
      parse = subtract.inDays ~/ 7;
      if (parse == 1) {
        return "$parse semana";
      } else {
        return "$parse semanas";
      }
    } else if (hours > 672 && hours <= 8760) {
      parse = subtract.inDays ~/ 30;
      if (parse == 1) {
        return "$parse mês";
      } else {
        return "$parse meses";
      }
    } else {
      parse = subtract.inDays ~/ 365;
      if (parse == 1) {
        return "$parse ano";
      } else {
        return "$parse anos";
      }
    }
  }
}
