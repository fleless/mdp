import 'package:mdp/network/api/device_api_provider.dart';

class DeviceRepository {
  DeviceApiProvider _apiProvider = new DeviceApiProvider();

  Future<bool> registerDevice(
      String deviceToken, num personId, String personData) async {
    return _apiProvider.registerDevice(deviceToken, personId, personData);
  }
}
