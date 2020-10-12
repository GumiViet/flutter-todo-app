import 'package:flutter/material.dart';
import 'package:flutter_to_do/screens/home/stack/photo/photo.indicator.dart';

class PhotoView extends StatefulWidget {
  final List<String> photoAssetPaths;
  final int visiblePhotoIndex;

  PhotoView({this.photoAssetPaths, this.visiblePhotoIndex});

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  int visiblePhotoIndex;

  @override
  void initState() {
    super.initState();
    visiblePhotoIndex = widget.visiblePhotoIndex;
  }

  void _prevImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex > 0
          ? visiblePhotoIndex - 1
          : widget.photoAssetPaths.length - 1;
    });
  }

  void _nextImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex < widget.photoAssetPaths.length - 1
          ? visiblePhotoIndex + 1
          : 0;
    });
  }

  Widget _buildBackground() {
    return widget.photoAssetPaths != null
        ? Image.asset(
            widget.photoAssetPaths[visiblePhotoIndex],
            fit: BoxFit.cover,
          )
        : Container();
  }

  Widget _buildIndicator() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: PhotoIndicator(
        photoCount: widget.photoAssetPaths.length,
        visiblePhotoIndex: visiblePhotoIndex,
      ),
    );
  }

  Widget _buildControls() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onTap: _prevImage,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        GestureDetector(
          onTap: _nextImage,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.photoAssetPaths.forEach((path) {
      precacheImage(AssetImage(path), context);
    });

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildBackground(),
        _buildIndicator(),
        _buildControls(),
      ],
    );
  }
}
