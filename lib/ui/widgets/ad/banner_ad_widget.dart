import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/presenters/ad/banner_ad_presenter.dart';

final bannerAdProvider = StateNotifierProvider<BannerAdPresenter, BannerAd?>(
  (_) => BannerAdPresenter(null),
);

class BannerAdWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final banner = useProvider(bannerAdProvider);
    final width = MediaQuery.of(context).size.width.truncate();
    useEffect(() {
      final provider = context.read(bannerAdProvider.notifier);
      provider.loadBanner(width);
      return provider.disposeBanner;
    }, const []);
    if (banner == null) {
      return Container();
    } else {
      return Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: AdWidget(ad: banner),
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
      );
    }
  }
}
