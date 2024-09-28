import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class PositionedCardFinal extends StatefulWidget {
  final Offset initialPosition;
  final Widget containerChild;
  final String imageChild;
  final String backImageChild;
  final Duration delay;
  final double containerWidth;
  final double containerHeight;
  final double cardWidth;
  final double cardHeight;
  final FlipCardController flipCardController;

  PositionedCardFinal({
    required this.initialPosition,
    required this.containerChild,
    required this.imageChild,
    required this.backImageChild,
    required this.containerWidth,
    required this.containerHeight,
    required this.cardWidth,
    required this.cardHeight,
    required this.flipCardController,
    this.delay = Duration.zero,
  });

  @override
  _PositionedCardFinalState createState() => _PositionedCardFinalState();
}

class _PositionedCardFinalState extends State<PositionedCardFinal> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  Animation<Offset>? _animation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    Future.delayed(widget.delay, () {
      setState(() {
        _animation = Tween<Offset>(
          begin: Offset(-1, -1),
          end: widget.initialPosition,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_animation != null) {
          return Stack(
            children: [
              Positioned(
                top: _animation!.value.dy,
                left: _animation!.value.dx,
                child: SizedBox(
                  width: widget.containerWidth,
                  height: widget.containerHeight,
                  child: widget.containerChild,
                ),
              ),
              Positioned(
                top: _animation!.value.dy,
                left: _animation!.value.dx,
                child: FlipCard(
                  flipOnTouch: false,
                  controller: widget.flipCardController,
                  front: buildFrontCard(),
                  back: buildBackCard(),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildFrontCard() {
    return Container(
      color: Colors.green,
      width: widget.containerWidth,
      height: widget.containerHeight,
      child: Image.asset(widget.imageChild,fit: BoxFit.fill,),
    );
  }

  Widget buildBackCard() {
    return Container(
        color: Colors.transparent,
        width: widget.containerWidth,
        height: widget.containerHeight,
        child: Image.asset('${widget.backImageChild}',fit: BoxFit.fill,)
    );
  }
}

