import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate = DateFormat("yyyy-MM-dd h:mm").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 hafta ' : 'Geçen hafta';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 gün önce' : 'Dün';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} saat önce';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 saat önce' : 'Bir saat önce';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 dakika önce' : 'Bir dakika önce';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} saniye önce';
    } else {
      return 'Az önce';
    }
  }
}
