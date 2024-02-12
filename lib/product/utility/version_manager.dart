import 'package:fullstack_firebase_news_app/product/utility/exceptions/custom_exception.dart';

class VersionManager {
  VersionManager({required this.deviceValue, required this.dataBaseValue});

  final String deviceValue;
  final String dataBaseValue;

  bool isNeeUpdate() {
    final deviceNumberSplited = deviceValue.split('.').join();
    final databaseNumberSplited = dataBaseValue.split('.').join();

    final deviceNumber = int.tryParse(deviceNumberSplited);
    final databaseNumber = int.tryParse(databaseNumberSplited);

    if (deviceNumber == null || databaseNumber == null) {
      throw VersionCustomException(
          '$deviceNumber or $databaseNumber is not valid for parse');
    }
    return deviceNumber < databaseNumber;
  }
}
