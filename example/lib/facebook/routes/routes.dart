import 'package:example/facebook/pages/facebook_groups_page.dart';
import 'package:example/facebook/pages/facebook_home_page.dart';
import 'package:example/facebook/pages/facebook_marketplace_page.dart';
import 'package:example/facebook/pages/facebook_messenger_page.dart';
import 'package:example/facebook/pages/facebook_profile_page.dart';
import 'package:example/facebook/pages/facebook_search_page.dart';
import 'package:example/facebook/pages/facebook_video_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String video = '/video';
  static const String marketplace = '/marketplace';
  static const String groups = '/groups';
  static const String profile = '/profile';
  static const String messenger = '/messenger';
  static const String search = '/search';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const FacebookHomePage(),
      video: (context) => const FacebookVideoPage(),
      marketplace: (context) => const FacebookMarketplacePage(),
      groups: (context) => const FacebookGroupsPage(),
      profile: (context) => const FacebookProfilePage(),
      messenger: (context) => const FacebookMessengerPage(),
      search: (context) => const FacebookSearchPage(),
    };
  }
}
