import 'package:intl/intl.dart';

String formatCustomDate(String input) {
  // Convertir le string en DateTime
  final inputFormat = DateFormat('dd-MM-yyyy HH:mm');
  final dateTime = inputFormat.parse(input);

  // Formater en "Dim. 8 Juin à 16h00"
  final dayAbbreviation = DateFormat.E('fr_FR').format(dateTime); // Dim.
  final dayNumber = dateTime.day;
  final monthName = DateFormat.MMMM('fr_FR').format(dateTime); // Juin
  final hour = DateFormat('HH').format(dateTime);
  final minute = DateFormat('mm').format(dateTime);

  return '$dayAbbreviation $dayNumber $monthName à ${hour}h${minute}';
}

String formatCustomDateDay(String input) {
  // Convertir le string en DateTime
  final inputFormat = DateFormat('dd-MM-yyyy HH:mm');
  final dateTime = inputFormat.parse(input);

  // Formater en "Dim. 8 Juin à 16h00"
  final dayAbbreviation = DateFormat('EEEE', 'fr_FR').format(dateTime); // Dim.
  final dayNumber = dateTime.day;
  final monthName = DateFormat.MMMM('fr_FR').format(dateTime); // Juin
  final hour = DateFormat('HH').format(dateTime);
  final minute = DateFormat('mm').format(dateTime);

  return '$dayAbbreviation $dayNumber $monthName à ${hour}h${minute}';
}

String formatSmartDate(String inputDateString) {
  final inputFormat = DateFormat('dd-MM-yyyy HH:mm');
  final date = inputFormat.parse(inputDateString);

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(Duration(days: 1));
  final afterTomorrow = today.add(Duration(days: 2));
  final targetDay = DateTime(date.year, date.month, date.day);

  final hour = DateFormat('HH').format(date);
  final minute = DateFormat('mm').format(date);

  if (targetDay == today) {
    return 'Aujourd’hui à ${hour}h$minute';
  } else if (targetDay == tomorrow) {
    return 'Demain à ${hour}h$minute';
  } else if (targetDay == afterTomorrow) {
    return 'Après-demain à ${hour}h$minute';
  } else {
    final dayName = DateFormat('EEEE', 'fr_FR').format(date); // Ex: Dimanche
    final dayNumber = date.day;
    final monthName = DateFormat('MMMM', 'fr_FR').format(date); // Ex: Juin
    return '$dayName $dayNumber $monthName à ${hour}h$minute';
  }
}
