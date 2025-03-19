import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/logic/local_news_bloc/local_news_bloc.dart';

class LocalNewsCarousel extends StatefulWidget {
  const LocalNewsCarousel({super.key});

  @override
  State<LocalNewsCarousel> createState() => _LocalNewsCarouselState();
}

class _LocalNewsCarouselState extends State<LocalNewsCarousel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalNewsBloc, LocalNewsState>(
        builder: (context, state) {
      if (state is LocalNewsLoaded && state.articles.isNotEmpty) {
        return CarouselSlider(
          items: state.articles.map((article) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    article.imageUrl != null
                        ? Image.network(
                            article.imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 150,
                              color: Colors.grey,
                            ),
                          ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        article.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
