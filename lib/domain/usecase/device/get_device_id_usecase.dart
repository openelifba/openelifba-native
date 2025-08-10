import 'package:device_info_plus/device_info_plus.dart';
import 'package:openelifba/core/domain/usecase/use_case.dart';

class GetDeviceIdUseCase extends UseCase<String, void> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> call({required void params}) async {
    var deviceInfoData = await deviceInfo.deviceInfo;
    if (deviceInfoData is AndroidDeviceInfo) {
      return deviceInfoData.id; // Android device ID
    } else if (deviceInfoData is IosDeviceInfo) {
      return deviceInfoData.identifierForVendor ?? 'unknown'; // iOS device ID
    }
    return 'unknown';
  }
}
