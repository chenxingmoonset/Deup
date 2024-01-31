import 'package:get/get.dart';
import 'package:deup/storages/index.dart';
import 'package:fijkplayer/fijkplayer.dart';

/// FijkPlayer Helper
/// [FijkHelper]
class FijkHelper {
  /// setFijkOption
  /// [player]
  static Future<void> setFijkOption(
    FijkPlayer player, {
    isAudioOnly = false,
    Map<String, String>? headers,
  }) async {
    // Set player
    player.setOption(FijkOption.playerCategory, 'framedrop', 5);
    player.setOption(FijkOption.playerCategory, 'mediacodec', 1);
    player.setOption(FijkOption.playerCategory, 'mediacodec-hevc', 1);
    player.setOption(FijkOption.playerCategory, 'videotoolbox', 1);
    player.setOption(FijkOption.playerCategory, 'enable-accurate-seek', 1);
    player.setOption(FijkOption.playerCategory, 'soundtouch', 1);
    player.setOption(FijkOption.playerCategory, 'subtitle', 1);

    // vn
    if (isAudioOnly) player.setOption(FijkOption.playerCategory, 'vn', 1);

    // Set format
    player.setOption(FijkOption.formatCategory, 'reconnect', 1);
    player.setOption(FijkOption.formatCategory, 'timeout', 30 * 1000 * 1000);
    player.setOption(FijkOption.formatCategory, 'fflags', 'fastseek');
    player.setOption(FijkOption.formatCategory, 'rtsp_transport', 'tcp');
    player.setOption(FijkOption.formatCategory, 'packet-buffering', 1);

    // max-buffer-size 100M
    player.setOption(
        FijkOption.formatCategory, 'max-buffer-size', 1024 * 1024 * 100);

    // AudioFocus
    await player.setOption(FijkOption.hostCategory, 'request-audio-focus', 1);
    await player.setOption(FijkOption.hostCategory, 'release-audio-focus', 1);

    // Set codec
    if (!Get.find<PreferencesStorage>().isHardwareDecode.val) {
      player.setOption(FijkOption.playerCategory, 'mediacodec', 0);
      player.setOption(FijkOption.playerCategory, 'mediacodec-hevc', 0);
      player.setOption(FijkOption.playerCategory, 'videotoolbox', 0);
    }

    // Set request headers
    String requestHeaders = '';
    headers?.forEach((key, value) {
      key.toLowerCase() == 'user-agent'
          ? player.setOption(FijkOption.formatCategory, 'user_agent', value)
          : requestHeaders += '${key}:${value}\r\n';
    });

    player.setOption(FijkOption.formatCategory, 'headers', requestHeaders);
  }

  /// 播放器时间转字符串
  /// [duration]
  static String formatDuration(Duration duration) {
    if (duration.inMilliseconds < 0) return "-: negtive";

    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int inHours = duration.inHours;
    return inHours > 0
        ? '$inHours:$twoDigitMinutes:$twoDigitSeconds'
        : '$twoDigitMinutes:$twoDigitSeconds';
  }
}
