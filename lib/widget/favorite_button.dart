import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/style.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButton({super.key, required this.restaurant,});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return CircleAvatar(
                backgroundColor: Colors.white,
                child: isFavorite
                    ? IconButton(
                  icon: const Icon(Icons.favorite),
                  color: primaryColor,
                  onPressed: () => provider.removeFavorite(restaurant.id),
                )
                    : IconButton(
                  icon: const Icon(Icons.favorite_border),
                  color: primaryColor,
                  onPressed: () => provider.addFavorite(restaurant),
                ));
          },
        );
      },
    );
  }
}