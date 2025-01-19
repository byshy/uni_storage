import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uni_storage/src/uni_storage_configs.dart';

typedef UniImageBuilder = Widget Function(BuildContext context, ImageProvider image);

class UniStorageImage extends StatefulWidget {
  /// Url For Image it be should Like this:
  /// https://$[bucketName].$[region].digitaloceanspaces.com/$[FolderName]/$[FileName]
  final String imageUrl;

  /// Widget to show while loading image
  final Widget? loadingWidget;

  /// Widget to show after loading image
  final UniImageBuilder? imageBuilder;

  /// Widget to show Error Widget
  final Widget? errorWidget;

  const UniStorageImage({
    Key? key,
    required this.imageUrl,
    this.loadingWidget,
    this.imageBuilder,
    this.errorWidget,
  }) : super(key: key);

  @override
  State<UniStorageImage> createState() => _UniStorageImageState();
}

class _UniStorageImageState extends State<UniStorageImage> {
  String get bucketName => widget.imageUrl.split('https://')[1].split('.')[0];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UniStorage.uniStorge!.bucket(bucketName).getImage(url:widget.imageUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (widget.imageBuilder != null
              ? widget.imageBuilder!(context, Image.memory(snapshot.data as Uint8List).image)
              : Image.memory(snapshot.data as Uint8List));
        } else if (snapshot.hasError) {
          return widget.errorWidget ?? Icon(Icons.image_not_supported_rounded, color: Colors.red);
        } else {
          return widget.loadingWidget ?? const CircularProgressIndicator();
        }
      },
    );
  }
}
