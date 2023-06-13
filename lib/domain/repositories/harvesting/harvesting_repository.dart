abstract class HarvestingRepository {
  Future<void> setAddress(String address, String token);
  Future<void> deleteAddress(String address, String token);
}
