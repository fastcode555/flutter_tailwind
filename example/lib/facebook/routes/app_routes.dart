import 'package:example/facebook/models/post.dart';
import 'package:example/facebook/models/story.dart';
import 'package:example/facebook/pages/facebook_chat_detail_page.dart';
import 'package:example/facebook/pages/facebook_chat_settings_page.dart';
import 'package:example/facebook/pages/facebook_comment_reply_page.dart';
import 'package:example/facebook/pages/facebook_comments_page.dart';
import 'package:example/facebook/pages/facebook_friends_page.dart';
import 'package:example/facebook/pages/facebook_image_edit_page.dart';
import 'package:example/facebook/pages/facebook_image_preview_page.dart';
import 'package:example/facebook/pages/facebook_main_page.dart';
import 'package:example/facebook/pages/facebook_messenger_page.dart';
import 'package:example/facebook/pages/facebook_notifications_page.dart';
import 'package:example/facebook/pages/facebook_post_detail_page.dart';
import 'package:example/facebook/pages/facebook_post_edit_page.dart';
import 'package:example/facebook/pages/facebook_search_results_page.dart';
import 'package:example/facebook/pages/facebook_settings_page.dart';
import 'package:example/facebook/pages/facebook_story_create_page.dart';
import 'package:example/facebook/pages/facebook_story_view_page.dart';
import 'package:example/facebook/pages/facebook_user_profile_page.dart';
import 'package:example/facebook/pages/facebook_video_call_page.dart';
import 'package:example/facebook/pages/facebook_voice_call_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = '/';
  static const String messenger = '/messenger';
  static const String notifications = '/notifications';
  static const String friends = '/friends';
  static const String settings = '/settings';
  static const String postDetail = '/post/detail';
  static const String comments = '/comments';
  static const String storyCreate = '/story/create';
  static const String storyView = '/story/view';
  static const String chat = '/chat';
  static const String commentReply = '/comment/reply';
  static const String search = '/search';
  static const String imageEdit = '/image/edit';
  static const String postEdit = '/post/edit';
  static const String voiceCall = '/voice-call';
  static const String videoCall = '/video-call';
  static const String chatSettings = '/chat-settings';
  static const String userProfile = '/user/profile';
  static const String imagePreview = '/image/preview';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const FacebookMainPage());
      case messenger:
        return MaterialPageRoute(builder: (_) => const FacebookMessengerPage());
      case notifications:
        return MaterialPageRoute(builder: (_) => const FacebookNotificationsPage());
      case friends:
        return MaterialPageRoute(builder: (_) => const FacebookFriendsPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const FacebookSettingsPage());
      case postDetail:
        final post = settings.arguments! as Post;
        return MaterialPageRoute(builder: (_) => FacebookPostDetailPage(post: post));
      case comments:
        final post = settings.arguments! as Post;
        return MaterialPageRoute(builder: (_) => const FacebookCommentsPage());
      case storyCreate:
        return MaterialPageRoute(builder: (_) => const FacebookStoryCreatePage());
      case storyView:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FacebookStoryViewPage(
            stories: args['stories'] as List<Story>,
            initialIndex: args['initialIndex'] as int? ?? 0,
          ),
        );
      case chat:
        return MaterialPageRoute(builder: (_) => const FacebookChatDetailPage());
      case commentReply:
        return MaterialPageRoute(builder: (_) => const FacebookCommentReplyPage());
      case search:
        return MaterialPageRoute(builder: (_) => const FacebookSearchResultsPage());
      case imageEdit:
        final imageUrl = settings.arguments! as String;
        return MaterialPageRoute(builder: (_) => FacebookImageEditPage(imageUrl: imageUrl));
      case postEdit:
        return MaterialPageRoute(builder: (_) => const FacebookPostEditPage());
      case voiceCall:
        final args = settings.arguments! as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => FacebookVoiceCallPage(
            userName: args['userName']!,
            userAvatar: args['userAvatar']!,
          ),
        );
      case videoCall:
        final args = settings.arguments! as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => FacebookVideoCallPage(
            userName: args['userName']!,
            userAvatar: args['userAvatar']!,
          ),
        );
      case chatSettings:
        final args = settings.arguments! as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => FacebookChatSettingsPage(
            userName: args['userName']!,
            userAvatar: args['userAvatar']!,
          ),
        );
      case userProfile:
        final userId = settings.arguments! as String;
        return MaterialPageRoute(
          builder: (_) => FacebookUserProfilePage(userId: userId),
        );
      case imagePreview:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FacebookImagePreviewPage(
            imageUrls: args['imageUrls'] as List<String>,
            initialIndex: args['initialIndex'] as int? ?? 0,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void toPostDetail(BuildContext context, Post post) {
    Navigator.pushNamed(context, postDetail, arguments: post);
  }

  static void toComments(BuildContext context, Post post) {
    Navigator.pushNamed(context, comments, arguments: post);
  }

  static void toStoryView(BuildContext context, List<Story> stories, {int initialIndex = 0}) {
    Navigator.pushNamed(
      context,
      storyView,
      arguments: {
        'stories': stories,
        'initialIndex': initialIndex,
      },
    );
  }

  static void toStoryCreate(BuildContext context) {
    Navigator.pushNamed(context, storyCreate);
  }

  static void toMessenger(BuildContext context) {
    Navigator.pushNamed(context, messenger);
  }

  static void toNotifications(BuildContext context) {
    Navigator.pushNamed(context, notifications);
  }

  static void toFriends(BuildContext context) {
    Navigator.pushNamed(context, friends);
  }

  static void toSettings(BuildContext context) {
    Navigator.pushNamed(context, settings);
  }

  static void toChat(BuildContext context) {
    Navigator.pushNamed(context, chat);
  }

  static void toCommentReply(BuildContext context) {
    Navigator.pushNamed(context, commentReply);
  }

  static void toSearch(BuildContext context) {
    Navigator.pushNamed(context, search);
  }

  static void toImageEdit(BuildContext context, String imageUrl) {
    Navigator.pushNamed(
      context,
      imageEdit,
      arguments: imageUrl,
    ).then((value) {
      // 处理编辑完成后的回调
      if (value != null) {
        // TODO: 处理编辑后的图片
      }
    });
  }

  static void toPostEdit(BuildContext context) {
    Navigator.pushNamed(context, postEdit);
  }

  static void toVoiceCall(BuildContext context, {
    required String userName,
    required String userAvatar,
  }) {
    Navigator.pushNamed(
      context,
      voiceCall,
      arguments: {
        'userName': userName,
        'userAvatar': userAvatar,
      },
    );
  }

  static void toVideoCall(BuildContext context, {
    required String userName,
    required String userAvatar,
  }) {
    Navigator.pushNamed(
      context,
      videoCall,
      arguments: {
        'userName': userName,
        'userAvatar': userAvatar,
      },
    );
  }

  static void toChatSettings(BuildContext context, {
    required String userName,
    required String userAvatar,
  }) {
    Navigator.pushNamed(
      context,
      chatSettings,
      arguments: {
        'userName': userName,
        'userAvatar': userAvatar,
      },
    );
  }

  static void toUserProfile(BuildContext context, String userId) {
    Navigator.pushNamed(context, userProfile, arguments: userId);
  }

  static void toImagePreview(
    BuildContext context,
    List<String> imageUrls, {
    int initialIndex = 0,
  }) {
    Navigator.pushNamed(
      context,
      imagePreview,
      arguments: {
        'imageUrls': imageUrls,
        'initialIndex': initialIndex,
      },
    );
  }
} 