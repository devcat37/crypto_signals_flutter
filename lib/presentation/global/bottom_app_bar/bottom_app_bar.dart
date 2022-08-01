import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:crypto_signals_july/presentation/global/bottom_app_bar/bottom_app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({
    Key? key,
    required this.currentIndex,
    required this.onPageChanged,
    this.items = const [],
  }) : super(key: key);

  /// Current active index.
  final int currentIndex;

  /// Bottom app bar items.
  final List<BottomAppBarItem> items;

  /// Callback при изменении страницы.
  final Function(int) onPageChanged;

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Expanded(
              child: GestureDetector(
                onTap: () => onPageChanged(items.indexOf(e)),
                child: _BottomAppBarItem(
                  title: e.title,
                  svgIcon: e.svgIcon,
                  color: e.color,
                  isActive: items.indexOf(e) == currentIndex,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.w + MediaQuery.of(context).padding.bottom,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: whiteColor.withOpacity(0.3),
            width: 1.0,
          ),
        ),
      ),
      child: _buildContent(context),
    );
  }
}

class _BottomAppBarItem extends StatelessWidget {
  const _BottomAppBarItem({
    Key? key,
    required this.title,
    required this.svgIcon,
    this.isActive = false,
    this.color,
  }) : super(key: key);

  /// Активный элемент или нет.
  final bool isActive;

  /// Заголовок.
  final String title;

  /// SVG путь до иконки.
  final String svgIcon;

  /// Цвет of the item.
  final Color? color;

  Widget _buildIcon(BuildContext context) {
    return SvgPicture.asset(
      svgIcon,
      color: color ?? (isActive ? blueColor : whiteColor.withOpacity(0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(context),
            if (isActive)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 11.w, color: color ?? blueColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
