import 'package:crypto_signals_july/internal/pages/premium_screen/premium_screen.dart';
import 'package:crypto_signals_july/internal/pages/settings_screen/settings_screen.dart';
import 'package:crypto_signals_july/internal/pages/signals_screen/signals_screen.dart';
import 'package:crypto_signals_july/internal/pages/trading_screen/trading_screen.dart';
import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/states/subscription_state/subscription_state.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/bottom_app_bar/bottom_app_bar_item.dart';
import 'package:crypto_signals_july/presentation/global/icons/q_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'bottom_app_bar_state.g.dart';

class BottomAppBarState = _BottomAppBarStateBase with _$BottomAppBarState;

abstract class _BottomAppBarStateBase with Store {
  SubscriptionState get subscriptionState => service<SubscriptionState>();

  /// Page controller.
  final PageController pageController = PageController();

  @observable
  int currentIndex = 0;

  @computed
  Map<BottomAppBarItem, Widget> get _itemToPage => {
        const BottomAppBarItem(title: 'Trading', svgIcon: QIcons.trading): const TradingScreen(),
        if (!subscriptionState.isSubscribed)
          const BottomAppBarItem(title: 'Premium', svgIcon: QIcons.premium, color: yellowColor): const PremiumScreen(),
        const BottomAppBarItem(title: 'Signals', svgIcon: QIcons.signals): const SignalsScreen(),
        const BottomAppBarItem(title: 'Settings', svgIcon: QIcons.settings): const SettingsScreen(),
      };

  @computed
  List<BottomAppBarItem> get items => _itemToPage.keys.toList();

  @computed
  List<Widget> get pages => _itemToPage.values.toList();

  void changePage(int index) {
    if (index == currentIndex) return;

    pageController.jumpToPage(index);
    currentIndex = index;
  }
}
