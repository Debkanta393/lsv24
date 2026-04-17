import 'package:metube/utils/constant/app_constant.dart';
import 'package:metube/utils/settings/app_settings.dart';

class ConvertToNetwork {
  /// Converts any relative path like "/uploads/video.mp4"
  /// into a full URL: "http://192.168.0.209:5000/uploads/video.mp4"
  /// If already a full URL, returns as-is.
  static Future<String> convert(String url) async {
    return resolve(url);
  }

  /// Synchronous version — use this everywhere
  static String resolve(String url) {
    if (url.isEmpty) {
      AppSettings.showLog("⚠️ ConvertToNetwork: empty URL");
      return '';
    }

    // Already a full URL
    if (url.startsWith('http://') || url.startsWith('https://')) {
      AppSettings.showLog("✅ ConvertToNetwork: already full URL => $url");
      return url;
    }

    // ✅ Relative path → prepend mediaBaseURL (domain only, no /api/)
    String base = Constant.mediaBaseURL.endsWith('/')
        ? Constant.mediaBaseURL.substring(0, Constant.mediaBaseURL.length - 1)
        : Constant.mediaBaseURL;

    String path = url.startsWith('/') ? url : '/$url';
    String fullUrl = '$base$path';

    AppSettings.showLog("✅ ConvertToNetwork: resolved => $fullUrl");
    return fullUrl;
  }
}
