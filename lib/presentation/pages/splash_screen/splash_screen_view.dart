import 'package:crypto_signals_july/internal/services/app_redirects.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/loader/q_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.wait([]);

    SchedulerBinding.instance?.addPostFrameCallback(
      (_) {
        Future.delayed(
          aSecond * 3,
          () => replaceWithWorkspace(context),
        );
      },
    );

    super.initState();
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset('assets/logo.svg'),
          const Spacer(),
          const QLoader(),
          SizedBox(height: 24.h),
          SvgPicture.asset('assets/logo_text.svg'),
          SizedBox(height: 48.h + MediaQuery.of(context).padding.bottom),
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
