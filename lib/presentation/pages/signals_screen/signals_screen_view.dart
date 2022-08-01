import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/states/generate_data_state/generate_data_state.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/signal_wrapper/signal_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalsScreenView extends StatelessWidget {
  const SignalsScreenView({Key? key}) : super(key: key);

  GenerateDataState get state => service<GenerateDataState>();

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Observer(
            builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  'Free access signals',
                  style: TextStyle(fontSize: 20.w, color: whiteColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.h),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.freeSignals.length,
                  itemBuilder: (context, index) => SignalWrapper(signal: state.freeSignals.elementAt(index)),
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                ),
                SizedBox(height: 34.h),
                Text(
                  'Premium signals',
                  style: TextStyle(fontSize: 20.w, color: whiteColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.h),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.premiumSignals.length,
                  itemBuilder: (context, index) => SignalWrapper(signal: state.premiumSignals.elementAt(index)),
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                ),
                SizedBox(height: 34.h),
              ],
            ),
          ),
        ),
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
