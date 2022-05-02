import 'package:timeago/timeago.dart';

class BulgarianMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Току що';
  @override
  String aboutAMinute(int minutes) => 'Преди около минута';
  @override
  String minutes(int minutes) =>
      'Преди $minutes минут${minutes == 1 ? 'a' : 'и'}';
  @override
  String aboutAnHour(int minutes) => 'Преди около час';
  @override
  String hours(int hours) => 'Преди $hours час${hours == 1 ? '' : 'а'}';
  @override
  String aDay(int hours) => 'Преди около ден';
  @override
  String days(int days) => 'Преди $days ${days == 1 ? 'ден' : 'дни'}';
  @override
  String aboutAMonth(int days) => 'Преди около месец';
  @override
  String months(int months) => 'Преди $months месец${months == 1 ? '' : 'а'}';
  @override
  String aboutAYear(int year) => 'Преди около година';
  @override
  String years(int years) => 'Преди $years години';
  @override
  String wordSeparator() => ' ';
}
