import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/account/supplemental_public_keys_model.dart';

void main() {
  group('supplemental_public_keys_model_test', () {
    test('JSONからの変換', () {
      var model = SupplementalPublicKeysModel.fromJson({
        "linked": {
          "publicKey":
              "979D6A42269F92DE524267FA4196AFD3BD94A938400E23970D9786D7DE92B253"
        },
        "vrf": {
          "publicKey":
              "07B8C7942C4049BFB393241C80064EA1EB75C2674C343811B2481943E19CFB3A"
        }
      });
      expect(
        model.linked,
        '979D6A42269F92DE524267FA4196AFD3BD94A938400E23970D9786D7DE92B253',
      );
      expect(model.node, isNull);
      expect(model.voting, isNull);
      expect(
        model.vrf,
        '07B8C7942C4049BFB393241C80064EA1EB75C2674C343811B2481943E19CFB3A',
      );
    });
  });
}
