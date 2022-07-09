import 'package:flutter/material.dart';

class FiveStarsView extends StatefulWidget {
  const FiveStarsView(
      {Key? key,
      required this.mainAxisAlignment,
      required this.starCount,
      this.height = 20,
      this.direction = Axis.horizontal,
      this.totalStar = 5,
      this.width,
      this.iconSize,
      this.onTap,
      this.icon})
      : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final int starCount;
  final double height;
  final double? width;
  final Axis direction;
  final int totalStar;
  final double? iconSize;
  final IconData? icon;
  final Function(int)? onTap;

  @override
  State<FiveStarsView> createState() => _FiveStarsViewState();
}

class _FiveStarsViewState extends State<FiveStarsView> {
  int _starCount = 0;

  @override
  void initState() {
    super.initState();
    setStarCount(widget.starCount);
  }

  void setStarCount(int starCount) {
    setState(() {
      _starCount = starCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: widget.direction,
        itemCount: widget.totalStar,
        itemBuilder: (context, index) {
          return _FiveStars(
            starCount: _starCount,
            index: index,
            size: widget.iconSize,
            icon: widget.icon,
            setStarCount: (index) {
              //first star's index is 0
              setStarCount(index + 1);
              if (widget.onTap != null) {
                widget.onTap!(index + 1);
              }
            },
          );
        },
      ),
    );
  }
}

class _FiveStars extends StatelessWidget {
  const _FiveStars({
    Key? key,
    required this.starCount,
    required this.index,
    required this.setStarCount,
    this.size = _defaultIconSize,
    this.splashFactory,
    this.splashColor,
    this.icon,
  }) : super(key: key);

  static const double _defaultIconSize = 24.0;
  final int starCount;
  final int index;
  final double? size;
  final Function(int) setStarCount;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color? splashColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setStarCount(index);
      },
      //[InkSplash.splashFactory]
      //[InkRipple.splashFactory]
      splashFactory: splashFactory ?? NoSplash.splashFactory,
      splashColor: splashColor ?? Theme.of(context).splashColor,
      child: Icon(
        icon ?? Icons.star,
        size: size ?? _defaultIconSize,
        color: index <= starCount - 1
            ? Colors.yellow
            : Colors.yellow.withOpacity(0.2),
      ),
    );
  }
}
