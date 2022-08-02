import 'package:crypto_signals_july/internal/application.dart';
import 'package:crypto_signals_july/internal/services/helpers.dart';
import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/services/settings.dart';
import 'package:crypto_signals_july/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:crypto_signals_july/internal/states/generate_data_state/generate_data_state.dart';

import 'package:crypto_signals_july/internal/states/subscription_state/subscription_state.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:traffic_router/traffic_router.dart' as tr;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:apphud/apphud.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

final api = 'app_Nc2j2NDdHMsSQVGtJGqgdy3mojy15t';
final productID = 'prm_crpt_sgnls';

final termsOfUse = 'https://docs.google.com/document/d/1rkr-qiNaRvHZJprQgarh3RmcBaPokIzkg4-sjINc5VU/edit?usp=sharing';
final privacyPolicy =
    'https://docs.google.com/document/d/1XnNtmZPBaZX_WpYTcGaR2G7_a0affVu4znwEiGrFu4g/edit?usp=sharing';
final support =
    'https://docs.google.com/forms/d/e/1FAIpQLSd2AtF62q9iRm-3JcSsIagd-C4QLN6B8nQac_L1PTcRdDCskw/viewform?usp=sf_link';

// Этот контроллер подписки может использоваться в StreamBuilder
final StreamController<bool> subscribedController = StreamController.broadcast();
// Через эту переменную можно смотреть состояние подписки юзера
bool subscribed = false;
late Stream<bool> subscribedStream;
late StreamSubscription<bool> subT;

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> purchase() async {
  final res = await Apphud.purchase(productId: productID);
  if ((res.nonRenewingPurchase?.isActive ?? false) || kDebugMode) {
    subscribedController.add(true);
    return true;
  }
  return false;
}

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> restore() async {
  final res = await Apphud.restorePurchases();
  if (res.purchases.isNotEmpty || kDebugMode) {
    subscribedController.add(true);
    return true;
  }
  return false;
}

// Эти 3 метода нужны для показа вебвью с пользовательским соглашением, саппортом. Оставить в этом файле (main.dart), вызывать из экрана покупки, настроек
openTermsOfUse() {
  launch(termsOfUse);
}

openPrivacyPolicy() {
  launch(privacyPolicy);
}

openSupport() {
  launch(support);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Apphud.start(apiKey: api);

  final trafficRouter = await tr.TrafficRouter.initialize(
      settings: tr.Settings(
          paramNames: tr.ParamNames(
    databaseRoot: 'json_crp_trading',
    baseUrl1: '-',
    baseUrl2: '-',
    url11key: 'lokis',
    url12key: 'french',
    url21key: 'kilo',
    url22key: 'milo',
  )));

  if (trafficRouter.url.isEmpty) {
    subscribedStream = subscribedController.stream;
    subT = subscribedStream.listen((event) {
      subscribed = event;
      service<SubscriptionState>().isSubscribed = event;
    });
    if (await Apphud.isNonRenewingPurchaseActive(productID)) {
      subscribedController.add(true);
      service<SubscriptionState>().isSubscribed = true;
    }
    startMain();
  } else {
    AppReview.requestReview;
    if (trafficRouter.override) {
      await _launchInBrowser(trafficRouter.url);
    } else {
      runApp(MaterialApp(
        home: WebViewPage(
          url: trafficRouter.url,
        ),
      ));
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webController;
  late String webviewUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _enableRotation();
    webviewUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((await _webController?.canGoBack()) ?? false) {
          await _webController?.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: webviewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (con) {
              print('complete');
              _webController = con;
            },
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}

void startMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings.
  final settings = Settings();
  await settings.initFirebase();
  await settings.initStorage();
  await rateMyApp.init();

  service.registerSingleton(settings);

  // States.
  service.registerLazySingleton<BottomAppBarState>(() => BottomAppBarState());
  service.registerLazySingleton<SubscriptionState>(() => SubscriptionState());
  service.registerLazySingleton<GenerateDataState>(() => GenerateDataState());

  runApp(const Application());
}
