import 'package:uni_storage/uni_storage.dart';

class UniStorage {
  UniStorage._();
  static Spaces? uniStorge;

  static init({
    required String region,
    required String accessKey,
    required String secretKey,
  }) {
    uniStorge = Spaces(
      region: region,
      accessKey: accessKey,
      secretKey: secretKey,
    );
  }

}
