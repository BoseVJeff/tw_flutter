import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TwAnimationSpin extends StatefulWidget {
  final Widget? child;

  const TwAnimationSpin({super.key, this.child});

  @override
  State<TwAnimationSpin> createState() => _TwAnimationSpinState();
}

class _TwAnimationSpinState extends State<TwAnimationSpin>
    with TickerProviderStateMixin {
  late final AnimationController _basicController = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
    lowerBound: 0,
    upperBound: 1,
  )..repeat(reverse: false);

  late final _animation = CurvedAnimation(
    parent: _basicController,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    return _AnimatedTransform(animation: _animation, child: widget.child);
  }

  @override
  void dispose() {
    _animation.dispose();
    _basicController.dispose();
    super.dispose();
  }
}

class _AnimatedTransform extends AnimatedWidget {
  const _AnimatedTransform({
    required CurvedAnimation animation,
    required this.child,
  }) : _animation = animation,
       super(listenable: animation);

  final CurvedAnimation _animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: _animation.value * 2 * pi, child: child);
  }
}

class TwAnimatedPing extends StatefulWidget {
  final Widget? child;

  const TwAnimatedPing({super.key, this.child});

  @override
  State<TwAnimatedPing> createState() => _TwAnimatedPingState();
}

class _TwAnimatedPingState extends State<TwAnimatedPing>
    with SingleTickerProviderStateMixin {
  late AnimationController _parent;
  late CurvedAnimation _controller;

  @override
  void initState() {
    super.initState();
    _parent = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    )..repeat();
    _controller = CurvedAnimation(
      parent: _parent,
      curve: Interval(0, 0.75, curve: Cubic(0, 0, 0.2, 1)),
      // curve: Split(
      //   0.75,
      //   beginCurve: ,
      //   endCurve: Curves.linear,
      // ),
    );
  }

  @override
  void dispose() {
    _parent.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedPingWidget(listenable: _controller, child: widget.child);
  }
}

class _AnimatedPingWidget extends AnimatedWidget {
  final Widget? child;

  const _AnimatedPingWidget({this.child, required super.listenable});

  @override
  Widget build(BuildContext context) {
    double value = (super.listenable as CurvedAnimation).value;
    // value = ((value * 4) / 3).clamp(0, 1);
    return Opacity(
      opacity: 1 - value,
      child: Transform.scale(
        scale: value * 2,
        // child: Text(value.toString())
        child: child,
      ),
    );
  }
}

class TwAnimatedPulse extends StatefulWidget {
  final Widget? child;

  const TwAnimatedPulse({super.key, this.child});

  @override
  State<TwAnimatedPulse> createState() => _TwAnimatedPulseState();
}

class _TwAnimatedPulseState extends State<TwAnimatedPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _parent;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _parent = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(seconds: 2),
    )..repeat();
    _animation = CurvedAnimation(parent: _parent, curve: Cubic(0.4, 0, 0.6, 1));
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedPulseWidget(listenable: _animation, child: widget.child);
  }

  @override
  void dispose() {
    _parent.dispose();
    _animation.dispose();
    super.dispose();
  }
}

class _AnimatedPulseWidget extends AnimatedWidget {
  final Widget? child;

  const _AnimatedPulseWidget({this.child, required super.listenable});

  @override
  Widget build(BuildContext context) {
    double value =
        ((super.listenable as CurvedAnimation).value - 0.5).abs() + 0.5;
    return Opacity(
      opacity: value,
      // child: Text(value.toString()),
      child: child,
    );
  }
}

class TwAnimatedBounce extends StatefulWidget {
  final Widget? child;
  const TwAnimatedBounce({super.key, this.child});

  @override
  State<TwAnimatedBounce> createState() => _TwAnimatedBounceState();
}

class _TwAnimatedBounceState extends State<TwAnimatedBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _parent;
  late CurvedAnimation _animation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _parent = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _parent,
      curve: Cubic(0.8, 0, 1, 1),
      reverseCurve: Cubic(0, 0, 0.2, 1),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 0.25),
    ).animate(_animation);
  }

  @override
  void dispose() {
    _parent.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return _AnimatedBounceWidget(
    //   listenable: _animation,
    //   baseHeight: 10,
    //   child: widget.child,
    // );
    // return SizeBuilder(listenable: _animation, child: widget.child);
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}

class _AnimatedBounceWidget extends AnimatedWidget {
  final double baseHeight;
  final Widget? child;
  const _AnimatedBounceWidget({
    required super.listenable,
    required this.baseHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double value = ((super.listenable as CurvedAnimation).value) / 4;
    return Transform.translate(
      offset: Offset(0, value * baseHeight),
      child: child,
    );
  }
}

class SizeBuilder extends StatefulWidget {
  final Widget? child;
  final Listenable listenable;
  const SizeBuilder({super.key, this.child, required this.listenable});

  @override
  State<SizeBuilder> createState() => _SizeBuilderState();
}

class _SizeBuilderState extends State<SizeBuilder> {
  final GlobalKey _key = GlobalKey(debugLabel: "Sizing Key");
  bool isOffstage = false;
  Size? _size;
  late Animation<Offset> _offsetAnimation;

  Size? _getSize() {
    if (_key.currentContext!.mounted &&
        (_key.currentContext!.findRenderObject()! as RenderBox).hasSize) {
      return (_key.currentContext!.findRenderObject()! as RenderBox).size;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _size = _getSize();
        _offsetAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0, _size!.height),
        ).animate(widget.listenable as CurvedAnimation);
      });
    });
  }

  @override
  void didUpdateWidget(covariant SizeBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print("Widget updated!");
    _size = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _size = _getSize();
        _offsetAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0, _size!.height),
        ).animate(widget.listenable as CurvedAnimation);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_size == null) {
          return Offstage(
            key: _key,
            offstage: false,
            child: widget.child ?? SizedBox.square(dimension: 0),
          );
        } else {
          // return widget.child ?? SizedBox.square(dimension: 0);
          return _AnimatedBounceWidget(
            listenable: widget.listenable,
            baseHeight: _size!.height,
            child: widget.child,
          );
          // return SlideTransition(
          //   position: _offsetAnimation,
          //   child: widget.child,
          // );
        }
      },
    );
  }
}
