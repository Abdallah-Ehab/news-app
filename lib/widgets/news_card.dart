import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String? title;
  final String? image;
  final String? description;

  NewsCard({super.key, this.title, this.image, this.description});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: (){},
        child: Container(
          height: 300,
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              // Image layer with loading indicator
              Positioned.fill(
                child: image != null && image!.isNotEmpty
                    ? Image.network(
                        image!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image is loaded
                          } else {
                            return Center(
                              child: CircularProgressIndicator(), // Replace with your GIF widget if needed
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Container(color: Colors.grey); // Fallback for error
                        },
                      )
                    : Container(color: Colors.grey), // Fallback if no image URL
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Text layer
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title ?? "No Title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description ?? "No Description",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
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