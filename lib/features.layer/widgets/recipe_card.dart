import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app_flutter/features.layer/widgets/image.text_card.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int rating;
  final String totalTime;

  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          _buildMainContainer(context, imageProvider),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMainContainer(
      BuildContext context, ImageProvider<Object> imageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.34), BlendMode.multiply),
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: _buildMainChild(context),
    );
  }

  Widget _buildMainChild(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageTextCard(
                  imagePath: 'images/i_star.png',
                  title: '$rating',
                ),
                ImageTextCard(
                  imagePath: 'images/i_time.png',
                  title: totalTime,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
