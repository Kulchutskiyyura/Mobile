# lab2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


void _saveNetworkImage(String url) async {
    var key = 'AIzaSyAzU3CreMZ1lRkGzqPDjpML_chBNJ6nxz0';
    String path ='https://maps.googleapis.com/maps/api/place/photo?maxwidth=300&maxheight=300&photoreference=$url&key=$key';
    GallerySaver.saveImage(path).then((bool success) {
      setState(() {
        print('Image is saved');
      });
    });
  }
  