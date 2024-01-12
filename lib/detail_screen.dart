import 'package:dish_dash/style.dart';
import 'package:flutter/material.dart';
import 'model/restaurant.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';
  final Restaurant restaurant;

  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          style: const TextStyle(color: primaryColor, fontFamily: 'Hero'),
        ),
        elevation: 6,
        shadowColor: Colors.black,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        leading: const Icon(
          Icons.fastfood,
          color: primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: restaurant.id,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/imadages/medium/${restaurant.pictureId}',
                    height: 200,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, _) => Container(
                        height: 200,
                        child: const Center(
                            child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ))),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: secondaryColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  child: Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5,
                            offset: Offset(3, 3),
                            color: Colors.black26)
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: secondaryColor,
                          size: 30,
                        ),
                        Text(
                          restaurant.rating.toStringAsPrecision(2),
                          style: const TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.room_service,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        restaurant.categories.map((c) => c.name).join(", "),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${restaurant.city}, ${restaurant.address}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(restaurant.description),
                  SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Food',
                    style: TextStyle(
                        fontFamily: 'Hero',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...restaurant.menus.foods
                      .map((food) => _buildRestaurantItem(context, food.name)),
                  SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Drinks',
                    style: TextStyle(
                        fontFamily: 'Hero',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...restaurant.menus.drinks.map(
                      (drink) => _buildRestaurantItem(context, drink.name)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, String item) {
    // return Text(item);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Hero',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    AddItemWidget(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/image.jpg',
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            height: 0.5,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({super.key});

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return (itemCount > 0)
        ? Row(
            children: [
              IconButton.outlined(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: secondaryVariantColor),
                      foregroundColor: secondaryVariantColor),
                  onPressed: () {
                    setState(() {
                      itemCount--;
                    });
                  },
                  icon: Icon(Icons.remove)),
              SizedBox(
                width: 8,
              ),
              Text(
                itemCount.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              IconButton.outlined(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: secondaryVariantColor),
                      foregroundColor: secondaryVariantColor),
                  onPressed: () {
                    setState(() {
                      itemCount++;
                    });
                  },
                  icon: Icon(Icons.add)),
            ],
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: secondaryVariantColor),
                foregroundColor: secondaryVariantColor),
            child: Text(
              'Add',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                itemCount++;
              });
            },
          );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: primaryColor,
          )),
    );
  }
}
