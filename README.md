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
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uni_storage/uni_storage.dart';

class MyStorageApp extends StatefulWidget {
  @override
  _MyStorageAppState createState() => _MyStorageAppState();
}

class _MyStorageAppState extends State<MyStorageApp> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () async {
              Bucket bucket = UniStorage.bucket("bucket_name");
              image = await bucket.getFile('folder', 'file_name');
              setState(() {});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Get Image'),
                if (image != null) Image.memory(image!),
              ],
            ),
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