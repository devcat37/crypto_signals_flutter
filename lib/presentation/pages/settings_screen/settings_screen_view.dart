import 'package:crypto_signals_july/internal/services/helpers.dart';
import 'package:crypto_signals_july/internal/services/settings.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/icons/q_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreenView extends StatelessWidget {
  const SettingsScreenView({Key? key}) : super(key: key);

  List<Widget> _buttons(BuildContext context) => [
        _buildButton(
          context,
          title: 'Support',
          icon: QIcons.support,
          onTap: () => openSupport(),
        ),
      ];

  Widget _buildButton(BuildContext context,
      {required String title, required String icon, required Function() onTap, bool wide = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius8,
      child: Ink(
        height: 86.h,
        width: wide
            ? (MediaQuery.of(context).size.width - 2 * 16.w)
            : (MediaQuery.of(context).size.width - 2 * 16.w - 12.w) / 2,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: borderRadius8,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              SvgPicture.asset(icon, height: 24.r, width: 24.r, color: blueColor),
              SizedBox(height: 12.h),
              Text(
                title,
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          context,
          title: 'Support',
          icon: QIcons.support,
          onTap: () => openSupport(),
          wide: true,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              title: 'Privacy Policy',
              icon: QIcons.privacy,
              onTap: () => openPrivacy(),
            ),
            SizedBox(width: 12.w),
            _buildButton(
              context,
              title: 'Terms of Use',
              icon: QIcons.terms,
              onTap: () => openTerms(),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              title: 'Rate app',
              icon: QIcons.rate,
              onTap: () => rateMyApp.showRateDialog(context),
            ),
            SizedBox(width: 12.w),
            _buildButton(
              context,
              title: 'Share app',
              icon: QIcons.share,
              onTap: () => Share.share(Settings.appName),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 90.h),
          SvgPicture.asset('assets/logo.svg', height: 120.r),
          SizedBox(height: 16.h),
          Text(
            'Version 0.25',
            style: TextStyle(fontSize: 16.w, color: whiteColor.withOpacity(0.5)),
          ),
          SizedBox(height: 32.h),
          _buildButtons(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }
}
