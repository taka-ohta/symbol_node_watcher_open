import 'package:base32/base32.dart';

class Address {
  final String rawAddress;

  Address({required this.rawAddress});
  get base32Address => base32.encodeHexString(rawAddress).substring(0, 39);
  get formatAddress =>
      this.base32Address.replaceAllMapped(RegExp('.{6}'), (m) => '${m[0]}-');
}
