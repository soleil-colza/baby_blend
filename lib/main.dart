import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(BabyBlendApp());
}

class BabyBlendApp extends StatelessWidget {
  const BabyBlendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BabyBlendHome(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class BabyBlendHome extends StatefulWidget {
  const BabyBlendHome({Key? key}) : super(key: key);

  @override
  _BabyBlendHomeState createState() => _BabyBlendHomeState();
}

class _BabyBlendHomeState extends State<BabyBlendHome> {
  File? _image1;
  File? _image2;
  final picker = ImagePicker();

  Future getImage(int imageNumber) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else {
          _image2 = File(pickedFile.path);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[50],
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '赤ちゃんの顔を予想しよう！',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 249, 128, 173),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildPhotoUpload(1),
                  _buildPhotoUpload(2),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.blur_on, color: Colors.white),
                label: const Text('合成', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 211, 126, 234),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildPremiumBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUpload(int imageNumber) {
    File? image = imageNumber == 1 ? _image1 : _image2;
    return Column(
      children: <Widget>[
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: image == null
              ? Icon(Icons.camera_alt, size: 48, color: Colors.grey[400])
              : ClipOval(child: Image.file(image, fit: BoxFit.cover)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => getImage(imageNumber),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 125, 168),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            '写真を選択',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 194, 72),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.star, color: Colors.white),
          const SizedBox(width: 10),
          const Text(
            'プレミアムプランで更に楽しく！',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
