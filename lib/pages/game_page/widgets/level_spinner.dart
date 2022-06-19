import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

enum SpinnerColors { red, blue, green }

class LevelSpinner extends StatefulWidget {
  final double size;
  final SpinnerColors color;
  final bool stop;

  const LevelSpinner(
      {Key? key,
      this.size = 70.0,
      this.color = SpinnerColors.red,
      this.stop = false})
      : super(key: key);

  @override
  State<LevelSpinner> createState() => _LevelSpinnerState();
}

class _LevelSpinnerState extends State<LevelSpinner> with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _addListeners(_controller);
    _controller.repeat();
  }

  _addListeners(AnimationController controller) {
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stop) _controller.stop();
    return _buildAnimation();
  }

  AnimatedBuilder _buildAnimation() => AnimatedBuilder(
      animation: _animation as Listenable,
      builder: (ctx, ch) => RotationTransition(
          turns: turnsTween.animate(_controller),
          child: Container(
            color: Colors.transparent,
            child: LayoutGrid(
              columnSizes: [
                (widget.size / 3).px,
                (widget.size / 3).px,
                (widget.size / 3).px,
              ],
              rowSizes: [
                (widget.size / 3).px,
                (widget.size / 3).px,
                (widget.size / 3).px,
              ],
              columnGap: widget.size / 10,
              rowGap: widget.size / 10,
              children: List.generate(9, (index) => index)
                  .map((index) => Container(
                        decoration: BoxDecoration(
                            color: widget.color == SpinnerColors.red
                                ? const Color(0xFFFF0000)
                                    .withAlpha((index + 1) * 12)
                                : widget.color == SpinnerColors.blue
                                    ? const Color(0xFF0012FF)
                                        .withAlpha((index + 1) * 12)
                                    : widget.color == SpinnerColors.green
                                        ? const Color(0xFF00E051)
                                            .withAlpha((index + 1) * 12)
                                        : const Color(0xFF181818)
                                            .withRed((index + 1) * 12),
                            borderRadius: BorderRadius.circular(widget.size)),
                      ))
                  .toList(),
            ),
          )));
}
