import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SmallNativeAdsWidget extends StatefulWidget {
  const SmallNativeAdsWidget({Key? key}) : super(key: key);

  @override
  State<SmallNativeAdsWidget> createState() => _SmallNativeAdsWidgetState();
}

class _SmallNativeAdsWidgetState extends State<SmallNativeAdsWidget> {
  final double _adAspectRatioSmall = (91 / 355);

  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  String? _versionString;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-5294836995166944/8608953534'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  void initState() {
    _loadAd();
    _loadVersionString();

    super.initState();
  }

  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });

    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      factoryId: 'smallAdFactory',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          // ignore: avoid_print
          print('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // ignore: avoid_print
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
    )..load();
  }

  void _loadVersionString() {
    MobileAds.instance.getVersionString().then((value) {
      setState(() {
        _versionString = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * _adAspectRatioSmall,
              width: MediaQuery.of(context).size.width,
            ),
            if (_nativeAdIsLoaded && _nativeAd != null)
              SizedBox(
                height: MediaQuery.of(context).size.width * _adAspectRatioSmall,
                width: MediaQuery.of(context).size.width,
                child: AdWidget(ad: _nativeAd!),
              ),
          ],
        ),
        TextButton(
          onPressed: _loadAd,
          child: const Text("Refresh Ad"),
        ),
        if (_versionString != null) Text(_versionString!)
      ],
    );
  }
}
