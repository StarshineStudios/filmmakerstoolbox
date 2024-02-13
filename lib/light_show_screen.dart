import 'package:flutter/material.dart';

class LightShowScreen extends StatefulWidget {
  final List<Color> colors;
  final String effect;
  final double timingInSeconds;
  final bool pureHue;

  const LightShowScreen({
    Key? key,
    required this.colors,
    required this.effect,
    required this.timingInSeconds,
    required this.pureHue,
  }) : super(key: key);

  @override
  State<LightShowScreen> createState() => _LightShowScreenState();
}

class _LightShowScreenState extends State<LightShowScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  int _currentColorIndex = 0;

  //for the gradient.
  late Animation<Color?> _startColorAnimation;
  late Animation<Color?> _endColorAnimation;
  void _setupGradientAnimation() {
    _currentColorIndex = _currentColorIndex % widget.colors.length;
    int nextColorIndex = (_currentColorIndex + 1) % widget.colors.length;

    _startColorAnimation = ColorTween(
      begin: widget.colors[_currentColorIndex],
      end: widget.colors[nextColorIndex],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.linear),
    ));

    int secondNextColorIndex = (nextColorIndex + 1) % widget.colors.length;
    _endColorAnimation = ColorTween(
      begin: widget.colors[nextColorIndex],
      end: widget.colors[secondNextColorIndex],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.linear),
    ));

    _controller
      ..reset()
      ..forward();
  }

  @override
  void initState() {
    super.initState();

//make the pure hues pure

    // Initialize the AnimationController regardless of the effect
    _controller = AnimationController(
      duration: Duration(microseconds: (widget.timingInSeconds * 1000000).toInt()),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    if (widget.colors.isNotEmpty) {
      // Setup color animation for both 'Cycle' and 'None' effects
      // For 'None', this setup will simply not cycle beyond the first color
      _setupColorAnimation();
      if (widget.colors.length >= 2) {
        // Ensure there are at least two colors for the gradient
        //I will ensure that this is the case before I do this.
        _setupGradientAnimation();
      }

      _controller.forward();

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _currentColorIndex++;
          if (_currentColorIndex >= widget.colors.length) {
            _currentColorIndex = 0; // Reset to first color
          }
          _setupGradientAnimation();
          // For 'Instant', we need to manually trigger the change to ensure it's instant
          if (widget.effect == 'Instant') {
            setState(() {}); // Force widget to rebuild with the new color
          }

          _setupColorAnimation();
          _controller.forward(from: 0.0); // Restart the animation for both 'Cycle' and 'Instant'
        }
      });
    }
  }

  void _setupColorAnimation() {
    if (widget.effect == 'Cycle') {
      int nextColorIndex = _currentColorIndex + 1 < widget.colors.length ? _currentColorIndex + 1 : 0;
      _colorAnimation = ColorTween(
        begin: widget.colors[_currentColorIndex],
        end: widget.colors[nextColorIndex],
      ).animate(_controller);
    } else {
      // For both 'Instant' and 'None', set the color without tweening
      _colorAnimation = AlwaysStoppedAnimation<Color?>(widget.colors[_currentColorIndex]);
    }
  }

  Widget buildGradient(BuildContext context) {
    Color startColor = _startColorAnimation.value ?? widget.colors[0];
    Color endColor = _endColorAnimation.value ?? widget.colors[1];
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: GradientPainter(
                startColor: widget.pureHue ? pureHue(startColor) : startColor,
                endColor: widget.pureHue ? pureHue(endColor) : endColor,
              ),
              child: Container(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.effect == 'Gradient'
        ? buildGradient(context)
        : Scaffold(
            body: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    color: widget.pureHue ? pureHue(_colorAnimation.value ?? widget.colors.first) : (_colorAnimation.value ?? widget.colors.first),
                    child: const Center(
                      child: Text('Tap anywhere to go back', style: TextStyle(color: Colors.white, fontSize: 24)),
                    ),
                  );
                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GradientPainter extends CustomPainter {
  final Color startColor;
  final Color endColor;

  GradientPainter({required this.startColor, required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [startColor, endColor],
    );

    Paint paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // You can optimize this to only repaint when colors change
  }
}

Color pureHue(Color c) {
  HSLColor hsl = HSLColor.fromColor(c);
  hsl = hsl.withSaturation(1.0);
  hsl = hsl.withLightness(0.5);
  return hsl.toColor();
}
