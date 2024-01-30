# UniStorage

## Overview

UniStorage is a robust and user-friendly Flutter client library developed by the Unicode Team, designed to interact seamlessly with DigitalOcean Spaces. This package simplifies the process of storing and retrieving digital assets, making it an ideal solution for Flutter developers seeking efficient cloud storage integration.

## Features

- Easy-to-use Flutter integration.
- Support for DigitalOcean Spaces.
- Simplified methods for uploading and downloading files.
- Streamlined configuration and setup.

## Installation

To add `uni_storage` to your Flutter project, modify your `pubspec.yaml` file:

```yaml
dependencies:
  uni_storage: ^latest_version
```

## Getting Started

```
import 'package:uni_storage/uni_storage.dart';

void main() {
  UniStorageConfigs.init(
    region: "your_region",
    accessKey: "your_access_key",
    secretKey: "your_secret_key",
  );
  // Your Flutter app initialization
}
```

## Usage Example

```
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uni_storage/uni_storage.dart';

const String region = "Your Region";
const String accessKey = "Your Access Key";
const String secretKey = "Your Secret Key";
const String bucketName = "Your Bucket Name";
const String folderName = "Your Folder Name";
const String fileName = "Your File Name";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UniStorage.init(
    region: region,
    accessKey: accessKey,
    secretKey: secretKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniStorage',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  UniStorage.uniStorge!
                      .bucket(bucketName)
                      .getFile(
                        url: 'https://$bucketName.$region.digitaloceanspaces.com/$folderName/$fileName',
                        dir: await getTemporaryDirectory(),
                      )
                      .then((value) {
                    setState(() {
                      image = value;
                    });
                  });
                },
                child: const Text('Get Image'),
              ),
              UniStorgeImage(
                imageUrl: 'https://$bucketName.$region.digitaloceanspaces.com/$folderName/$fileName',
                imageBuilder: (context, im) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: im,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                loadingWidget: const CupertinoActivityIndicator(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              if (image != null) Image.file(image!),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Contributing

Contributions to uni_storage are welcome. Please read the contribution guidelines.

## License

uni_storage is available under the MIT license. See the LICENSE file for more info.

Please note: Always keep your API keys and sensitive data secure and never include them in your public code repositories.
