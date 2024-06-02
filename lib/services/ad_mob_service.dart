import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded: $ad'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened: $ad'),
    onAdClosed: (Ad ad) => print('Ad closed: $ad'),
    onAdImpression: (Ad ad) => print('Ad impression: $ad'),
    onAdClicked: (Ad ad) => print('Ad clicked: $ad'),
  );

  static final NativeAdListener nativeAdListener = NativeAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded: $ad'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened: $ad'),
    onAdClosed: (Ad ad) => print('Ad closed: $ad'),
    onAdImpression: (Ad ad) => print('Ad impression: $ad'),
    onAdClicked: (Ad ad) => print('Ad clicked: $ad'),
  );
}
