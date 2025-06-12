import 'dart:ui';

/// All blurs defined in Tailwind CSS
abstract class TwBlur {
  static final ImageFilter xs = ImageFilter.blur(sigmaX: 4, sigmaY: 4);

  static final ImageFilter sm = ImageFilter.blur(sigmaX: 8, sigmaY: 8);

  static final ImageFilter md = ImageFilter.blur(sigmaX: 12, sigmaY: 12);

  static final ImageFilter lg = ImageFilter.blur(sigmaX: 16, sigmaY: 16);

  static final ImageFilter xl = ImageFilter.blur(sigmaX: 24, sigmaY: 24);

  static final ImageFilter xl2 = ImageFilter.blur(sigmaX: 40, sigmaY: 40);

  static final ImageFilter xl3 = ImageFilter.blur(sigmaX: 64, sigmaY: 64);
}
