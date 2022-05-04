import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    required this.url,
    required this.hash,
    Key? key,
    this.borderRadius,
    this.shadow,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  final String url;
  final String hash;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: shadow,
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => BlurHash(hash: hash),
        errorWidget: (context, url, error) {
          log(error.toString());
          return BlurHash(hash: hash);
        },
      );
}
