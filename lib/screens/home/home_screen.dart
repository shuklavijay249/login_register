import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Using carousel_slider package

class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {'image': 'assets/slider_image_1.png', 'title': 'Innovative Technology'},
      {'image': 'assets/slider_image_2.png', 'title': 'Beautiful Nature'},
      {'image': 'assets/slider_image_3.png', 'title': 'Amazing Architecture'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider
              CarouselSlider(
                items: carouselItems.map((item) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        height: 150, // Adjust height as needed
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 230.0, // Adjusted height for the carousel slider
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
              ),
              const SizedBox(height: 100),
              // Card with Image and Button
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    CardItem(
                      title: 'Sample Product',
                      subtitle: 'View Details',
                      onTap: () {
                        Get.to(() => PlaceholderScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder screen for the button navigation
class PlaceholderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: const Center(
        child: Text(
          'Details go here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CardItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
