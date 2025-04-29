import 'package:flutter/material.dart';
import 'package:food_ui/constant/dimensions.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool showDefaultImage;

  const CustomImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.borderRadius,
    this.showDefaultImage = false,
  });

  bool get isNetwork => imagePath.startsWith('http') || imagePath.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadiusDirectional.circular(borderRadius30px),
      child: imagePath.isEmpty
          ? _placeholder()
          : isNetwork
              ? Image.network(
                  imagePath,
                  width: width ?? double.maxFinite,
                  height: height ?? deviceHeight * 0.45,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder();
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    return _placeholder();
                  },
                )
              : Image.asset(
                  imagePath,
                  width: width ?? double.maxFinite,
                  height: height ?? deviceHeight * 0.45,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder();
                  },
                ),
    );
  }

  Widget _placeholder() {
    return showDefaultImage
        ? CustomImage(
            imagePath: "assets/images/avatar.png",
            borderRadius: BorderRadius.all(
              Radius.circular(deviceAvgScreenSize),
            ),
              width: width,
              height: height,
          )
        : Container(
            width: width ?? double.maxFinite,
            height: height ?? deviceHeight * 0.45,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
  }
}
