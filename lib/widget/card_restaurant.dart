import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/data/model/restaurant.dart';
import 'package:dish_dash/ui/detail_screen.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: restaurant.id,
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, _) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: secondaryColor,
                          size: 16,
                        ),
                        Text(restaurant.rating.toStringAsPrecision(2))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hero',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    restaurant.categories.map((c) => c.name).join(", "),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      Text(restaurant.city),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
