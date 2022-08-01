import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QLoader extends StatelessWidget {
  const QLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 4.w,
      color: whiteColor,
      valueColor: const AlwaysStoppedAnimation(whiteColor),
    );
  }
}
