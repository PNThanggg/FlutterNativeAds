import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'medium_native_ads_widget.dart';
import 'native_ads_widget.dart';
import 'small_native_ads_widget.dart';
import 'square_native_ads_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: [
      '9249D30A745C469EA2B4E1709CBB0707',
      '67D244F82659A1C2089201F1756DE7B1',
    ]),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                // Expanded(
                //   child: NativeAdsWidget(),
                // ),
                // Expanded(
                //   child: NativeAdsWidget(),
                // ),
                NativeAdsWidget(),
              ],
            ),
            Row(
              children: const [
                SmallNativeAdsWidget(),
              ],
            ),
            Row(
              children: const [
                MediumNativeAdsWidget(),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: SquareNativeAdsWidget(),
                ),
                Expanded(
                  child: SquareNativeAdsWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
