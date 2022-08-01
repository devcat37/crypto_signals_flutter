import 'package:crypto_signals_july/domain/models/signal/signal.dart';
import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:crypto_signals_july/internal/states/subscription_state/subscription_state.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/icons/q_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' as svg;
import 'package:crypto_signals_july/domain/models/signal/signal.dart';
import 'package:intl/intl.dart';

class SignalWrapper extends StatelessWidget {
  const SignalWrapper({Key? key, required this.signal}) : super(key: key);

  final Signal signal;

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd MMMM yyyy, HH:mm').format(signal.date),
            style: TextStyle(fontSize: 12.w, color: whiteColor.withOpacity(0.5)),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              if (!service<SubscriptionState>().isSubscribed && signal.isPremium)
                svg.SvgPicture.asset(QIcons.lock, height: 32.r, width: 32.r)
              else
                svg.SvgPicture.asset(signal.one.image, height: 32.r, width: 32.r),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${signal.one.shortTitle}/${signal.two.shortTitle}',
                    style: TextStyle(fontSize: 16.w, color: whiteColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    signal.one.title,
                    style: TextStyle(fontSize: 12.w, color: whiteColor.withOpacity(0.5)),
                  ),
                ],
              ),
              const Spacer(),
              if (!service<SubscriptionState>().isSubscribed && signal.isPremium) ...[
                Text(
                  'Premium',
                  style: TextStyle(fontSize: 16.w, color: whiteColor),
                ),
                SizedBox(width: 4.w),
                svg.SvgPicture.asset(QIcons.arrow_right, height: 24.r, width: 24.r),
              ] else ...[
                Text(
                  signal.period.asString,
                  style: TextStyle(fontSize: 16.w, color: signal.type == SignalType.up ? greenColor : redColor),
                ),
                SizedBox(width: 4.w),
                svg.SvgPicture.asset(
                  signal.type == SignalType.up ? QIcons.arrow_up : QIcons.arrow_down,
                  height: 24.r,
                  width: 24.r,
                  color: signal.type == SignalType.up ? greenColor : redColor,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!service<SubscriptionState>().isSubscribed && signal.isPremium) service<BottomAppBarState>().changePage(1);
      },
      child: Container(
        height: 90.w,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 1.0, color: whiteColor.withOpacity(0.5)),
          borderRadius: borderRadius16,
        ),
        child: _buildContent(context),
      ),
    );
  }
}
