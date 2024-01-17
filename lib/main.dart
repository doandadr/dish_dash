import 'package:dish_dash/data/api/api_service.dart';
import 'package:dish_dash/data/preferences/preferences_helper.dart';
import 'package:dish_dash/provider/preferences_provider.dart';
import 'package:dish_dash/provider/restaurant_details_provider.dart';
import 'package:dish_dash/provider/restaurant_list_provider.dart';
import 'package:dish_dash/provider/restaurant_search_provider.dart';
import 'package:dish_dash/ui/detail_screen.dart';
import 'package:dish_dash/ui/home_screen.dart';
import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/model/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder:
            (BuildContext context, PreferencesProvider value, Widget? child) {
          return MaterialApp(
            title: 'Dish Dash',
            theme: ThemeData(
              fontFamily: 'DMSans',
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    secondary: secondaryColor,
                    onPrimary: onPrimaryColor,
                    onSecondary: onSecondaryColor,
                  ),
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                elevation: 6,
                shadowColor: Colors.black,
                surfaceTintColor: Colors.transparent,
              ),

            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              DetailScreen.routeName: (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
            },
          );
        },
      ),
    );
  }
}
