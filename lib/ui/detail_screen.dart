import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/provider/restaurant_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../data/model/restaurant_list_result.dart';
import '../provider/result_state.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';
  final Restaurant restaurant;

  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) {
          return RestaurantDetailsProvider(
              apiService: ApiService(), restaurantId: restaurant.id);
        },
        child: _buildRestaurantDetails(context));
  }

  Widget _buildRestaurantDetails(BuildContext context) {
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
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    height: 200,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, _) => const SizedBox(
                        height: 200,
                        child: Center(
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
            Consumer<RestaurantDetailsProvider>(
              builder: (_, provider, __) {
                switch (provider.state) {
                  case ResultState.loading:
                    return const CircularProgressIndicator();

                  case ResultState.hasData:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.room_service,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                provider.result.restaurant.categories.map((c) => c.name).join(", "),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${provider.result.restaurant.city}, ${provider.result.restaurant.address}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(restaurant.description),
                          const SizedBox(
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
                          const SizedBox(
                            height: 8,
                          ),
                          ...provider.result.restaurant.menus.foods.map(
                                  (food) => _buildRestaurantItem(context, food.name)),
                          const SizedBox(
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
                          const SizedBox(
                            height: 8,
                          ),
                          ...provider.result.restaurant.menus.drinks.map(
                                  (drink) => _buildRestaurantItem(context, drink.name)),
                        ],
                      ),
                    );
                  case ResultState.noData:
                    return Center(
                      child: Material(
                        child: Text(provider.message),
                      ),
                    );
                  case ResultState.error:
                    return Center(
                      child: Material(
                        child: Text("Error: Could not receive data from network"),
                      ),
                    );
                  default:
                    return const Material(
                      child: Text(''),
                    );
                    return const Material(
                      child: Text(''),
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, String item) {
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
                    const SizedBox(
                      height: 8,
                    ),
                    const AddItemWidget(),
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

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
                      side: const BorderSide(color: secondaryVariantColor),
                      foregroundColor: secondaryVariantColor),
                  onPressed: () {
                    setState(() {
                      itemCount--;
                    });
                  },
                  icon: const Icon(Icons.remove)),
              const SizedBox(
                width: 8,
              ),
              Text(
                itemCount.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton.outlined(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: secondaryVariantColor),
                      foregroundColor: secondaryVariantColor),
                  onPressed: () {
                    setState(() {
                      itemCount++;
                    });
                  },
                  icon: const Icon(Icons.add)),
            ],
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: secondaryVariantColor),
                foregroundColor: secondaryVariantColor),
            child: const Text(
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
