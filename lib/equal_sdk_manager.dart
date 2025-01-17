import 'package:equal_sdk_flutter/model/equal_sdk_params.dart';
import 'package:equal_sdk_flutter/model/event_response.dart';

class EqualSDKManager {
  static const String PROD_APP_URL = 'https://equal.in';
  static const String TEST_APP_URL = 'https://staging.equal.in';

  String _getEqualDomain(EqualSDKConfig equalSDKConfig) =>
      equalSDKConfig.env.contains('pre-prod') ? TEST_APP_URL : PROD_APP_URL;

  Future<String?> getGatewayURL(
      EqualSDKConfig equalSDKConfig, Function(EventResponse) onError) async {
    try {

      final String equalDomain = _getEqualDomain(equalSDKConfig);

      final Map<String, String> queryParams = {
        'access_token': equalSDKConfig.token,
      };

      final Uri iframeUri = Uri.parse(equalDomain + '/pfm')
          .replace(queryParameters: queryParams);

      return iframeUri.toString();
    } catch (e) {
      const errorMessage =
          'Unable to load the pfm due to a technical error. Please try again.';
      onError(EventResponse(status: 'ON_ERROR', message: errorMessage));
      return null;
    }
  }
}
