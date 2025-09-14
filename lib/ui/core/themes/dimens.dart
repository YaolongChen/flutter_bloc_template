import 'package:flutter/material.dart';

abstract final class Dimens {
  const Dimens();

  EdgeInsets get screenPadding;

  static const Dimens desktop = _DimensDesktop();
  static const Dimens mobile = _DimensMobile();

  factory Dimens.of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 600) {
      return desktop;
    } else {
      return mobile;
    }
  }
}

final class _DimensDesktop extends Dimens {
  const _DimensDesktop();

  @override
  EdgeInsets get screenPadding =>
      const EdgeInsets.symmetric(vertical: 16, horizontal: 24);
}

final class _DimensMobile extends Dimens {
  const _DimensMobile();

  @override
  EdgeInsets get screenPadding =>
      const EdgeInsets.symmetric(vertical: 12, horizontal: 20);
}
