import 'dart:math';

import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageList;

  ImageSlider(this.imageList);

  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        child: Stack(
          children: <Widget> [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: <Widget>[
                for(var item in widget.imageList) Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(item),
                  ),
                )
              ],
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 10.0,
              child: DotsIndicator(
                controller: _pageController,
                itemCount: widget.imageList.length,
              ),
            ),
          ]
        ),
    );
  }
}