import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => print('ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print("failed to load ad : $error");
    },
    onAdOpened: (Ad) => print('ad opend'),
    onAdClosed: (ad) => print('ad closed'),
  );
}
