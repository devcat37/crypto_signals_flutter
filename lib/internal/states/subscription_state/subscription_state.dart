import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:mobx/mobx.dart';

part 'subscription_state.g.dart';

class SubscriptionState = _SubscriptionStateBase with _$SubscriptionState;

abstract class _SubscriptionStateBase with Store {
  @observable
  bool isSubscribed = false;

  @action
  Future<bool> subscribe() async {
    // Задержка для тестирования.
    await Future.delayed(aSecond * 2);

    isSubscribed = true;
    return isSubscribed;
  }

  @action
  Future<bool> restore() async {
    // Задержка для тестирования.
    await Future.delayed(aSecond * 2);

    isSubscribed = true;
    return isSubscribed;
  }
}
