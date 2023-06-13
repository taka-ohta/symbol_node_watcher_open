import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symbol_node_watcher/domain/repositories/harvesting/harvesting_repository.dart';

class HarvestingRepositoryFirestore extends HarvestingRepository {
  @override
  Future<void> setAddress(String address, String token) async {
    final document =
        FirebaseFirestore.instance.collection('cloud_messaging').doc('targets');
    await document.update({
      address: FieldValue.arrayUnion([token]),
    });
  }

  @override
  Future<void> deleteAddress(String address, String token) async {
    final document =
        FirebaseFirestore.instance.collection('cloud_messaging').doc('targets');
    await document.update({
      address: FieldValue.arrayRemove([token]),
    });
  }
}
