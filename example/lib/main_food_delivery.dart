import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Food Delivery',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          home: const FoodDeliveryPage(),
        );
      },
    );
  }
}

class FoodDeliveryPage extends StatefulWidget {
  const FoodDeliveryPage({super.key});

  @override
  State<FoodDeliveryPage> createState() => _FoodDeliveryPageState();
}

class _FoodDeliveryPageState extends State<FoodDeliveryPage> {
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    // 启动定时器自动轮播
    Future.delayed(const Duration(seconds: 1), _startBannerTimer);
  }

  void _startBannerTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
      _bannerController.animateToPage(
        _currentBannerIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startBannerTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('美食外卖'),
        actions: [
          Icons.location_on_outlined.icon.s24.mk,
          w8,
          '北京市朝阳区'.text.f14.mk,
          w16,
        ],
      ),
      body: listview.separated16.builder(
        3,
        (context, index) {
          if (index == 0) return _buildBanner();
          if (index == 1) return _buildCategories();
          return _buildRestaurants();
        },
      ),
    );
  }

  Widget _buildBanner() {
    return sizedBox.h160.child(
      PageView.builder(
        controller: _bannerController,
        itemCount: _banners.length * 1000, // 实现无限循环
        onPageChanged: (index) => setState(() => _currentBannerIndex = index % _banners.length),
        itemBuilder: (context, index) {
          final banner = _banners[index % _banners.length];
          return container.ph16.child(
            banner.imageUrl.image.rounded16.cover.mk,
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return container.ph16.child(
      column.children([
        'Categories'.text.bold.f16.pb12.mk,
        gridview.neverScroll.crossAxisCount4.spacing12.shrinkWrap.ratio90.builder(
          _categories.length,
          (context, index) {
            final category = _categories[index];
            return column.center.children([
              container.s50.rounded12.red.opacity50.child(
                category.iconUrl.image.s30.mk,
              ),
              h8,
              category.name.text.f12.center.mk,
            ]);
          },
        ),
      ]),
    );
  }

  Widget _buildRestaurants() {
    return column.children([
      'Popular Restaurants'.text.bold.ph16.f16.pb12.mk,
      listview.separated16.ph16.neverScroll.shrinkWrap.builder(
        _restaurants.length,
        (context, index) {
          final restaurant = _restaurants[index];
          return container.rounded16.cardShadow.white.child(
            column.children([
              restaurant.imageUrl.image.h160.roundedT16.wFull.cover.mk,
              column.crossStart.p12.children([
                row.children(
                  [
                    restaurant.name.text.bold.f16.expanded.mk,
                    container.ph8.pv4.rounded8.amber.opacity10.child(
                      '${restaurant.rating}分'.text.orange.bold.f12.mk,
                    ),
                  ],
                ),
                row.pt8.children(
                  [
                    '月售${restaurant.monthSales}'.text.grey.f12.pr16.mk,
                    '${restaurant.deliveryTime}分钟'.text.grey.f12.pr16.mk,
                    '${restaurant.distance}km'.text.grey.f12.mk,
                  ],
                ),
              ]),
            ]),
          );
        },
      ),
    ]);
  }
}

// 数据模型
class Banner {
  final String imageUrl;

  const Banner({required this.imageUrl});
}

class Category {
  final String name;
  final String iconUrl;

  const Category({required this.name, required this.iconUrl});
}

class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final int monthSales;
  final int deliveryTime;
  final double distance;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.monthSales,
    required this.deliveryTime,
    required this.distance,
  });
}

// 模拟数据
final _banners = [
  const Banner(
    imageUrl: 'https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141352.jpg',
  ),
  const Banner(
    imageUrl: 'https://img.freepik.com/free-photo/flat-lay-batch-cooking-composition_23-2149013938.jpg',
  ),
  const Banner(
    imageUrl: 'https://img.freepik.com/free-photo/fresh-gourmet-meal-beef-taco-generation_188544-9919.jpg',
  ),
];

final _categories = [
  const Category(name: '美食', iconUrl: 'https://img.icons8.com/color/96/000000/restaurant.png'),
  const Category(name: '快餐', iconUrl: 'https://img.icons8.com/color/96/000000/hamburger.png'),
  const Category(name: '饮品', iconUrl: 'https://img.icons8.com/color/96/000000/cafe.png'),
  const Category(name: '水果', iconUrl: 'https://img.icons8.com/color/96/000000/fruits.png'),
  const Category(name: '超市', iconUrl: 'https://img.icons8.com/color/96/000000/shop.png'),
  const Category(name: '蛋糕', iconUrl: 'https://img.icons8.com/color/96/000000/cake.png'),
  const Category(name: '药店', iconUrl: 'https://img.icons8.com/color/96/000000/pharmacy.png'),
  const Category(name: '鲜花', iconUrl: 'https://img.icons8.com/color/96/000000/flower.png'),
];

final _restaurants = [
  const Restaurant(
    name: '川味小馆',
    imageUrl: 'https://img.freepik.com/free-photo/delicious-chinese-food-black-background_635062-147.jpg',
    rating: 4.8,
    monthSales: 1280,
    deliveryTime: 30,
    distance: 2.5,
  ),
  const Restaurant(
    name: '粤式茶餐厅',
    imageUrl: 'https://img.freepik.com/free-photo/side-view-pilaf-with-stewed-beef-meat-plate_141793-5057.jpg',
    rating: 4.6,
    monthSales: 890,
    deliveryTime: 35,
    distance: 3.2,
  ),
  const Restaurant(
    name: '寿司之家',
    imageUrl:
        'https://img.freepik.com/free-photo/side-view-sushi-set-with-soy-sauce-chopsticks-wooden-serving-board_176474-3234.jpg',
    rating: 4.9,
    monthSales: 2150,
    deliveryTime: 25,
    distance: 1.8,
  ),
];
