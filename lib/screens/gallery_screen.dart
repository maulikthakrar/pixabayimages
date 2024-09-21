import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay/models/pixabay_model.dart';
import 'package:pixabay/providers/get_images.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagesProvider _provider = Get.put(ImagesProvider());
  List<Hits> _hits = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getImages();
  }

  Future<void> getImages() async {
    setState(() {
      _isLoading = true;
    });
    final response = await _provider.getImages('flowers');
    setState(() {
      _hits = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridItemWidth = 150;
    int crossAxisCount = (screenWidth / gridItemWidth).floor();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pixabay Images'),
        ),
        body: Container(
          child: !_isLoading
              ? _hits.isEmpty
                  ? const Center(
                      child: Text('No images found!'),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, // 2 images per row
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio:
                            0.7, // Adjust ratio to fit images and text
                      ),
                      padding: const EdgeInsets.all(10.0),
                      itemCount: _hits.length,
                      itemBuilder: (context, index) {
                        final image = _hits[index];
                        return _buildImageItem(image);
                      },
                    )
              : const CircularProgressIndicator(),
        ));
  }

  Widget _buildImageItem(Hits image) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              image.webformatURL ?? '', // URL for the image
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons
                    .error); // Display an error icon if the image fails to load
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Likes: ${image.likes}', // Display number of likes
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Views: ${image.views}', // Display number of views
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
