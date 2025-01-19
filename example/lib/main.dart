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
              UniStorageImage(
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