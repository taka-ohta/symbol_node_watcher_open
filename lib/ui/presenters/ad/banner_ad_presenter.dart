import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BannerAdPresenter extends StateNotifier<BannerAd?> {
  BannerAdPresenter(BannerAd? state) : super(state);

  Future<void> loadBanner(int width) async {
    final size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      width,
    );
    final banner = BannerAd(
      // TODO 本番用
      // adUnitId: Platform.isIOS
      //     ? 'ca-app-pub-5195839508870525/6268608221'
      //     : 'ca-app-pub-5195839508870525/8095667549',
      // テスト用
      adUnitId: Platform.isIOS
          ? 'ca-app-pub-3940256099942544/2934735716'
          : 'ca-app-pub-3940256099942544/6300978111',
      size: size!,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          this.state = ad as BannerAd;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          this.state = null;
        },
      ),
    );

    await banner.load();
  }

  Future<void> disposeBanner() async {
    this.state?.dispose();
    this.state = null;
  }
}
