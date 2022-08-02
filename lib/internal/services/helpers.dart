import 'package:crypto_signals_july/main.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

void openTerms() => launchUrl(Uri.parse(termsOfUse));
void openPrivacy() => launchUrl(Uri.parse(privacyPolicy));
void openSupport() => launchUrl(Uri.parse(support));

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 0, // Show rate popup on first day of install.
  minLaunches: 50, // Show rate popup after 5 launches of app after minDays is passed.
  appStoreIdentifier: '1637665970',
);
