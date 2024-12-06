import 'package:example/facebook/models/post.dart';
import 'package:example/facebook/models/product.dart';
import 'package:example/facebook/models/story.dart';
import 'package:example/facebook/pages/facebook_about_page.dart';
import 'package:example/facebook/pages/facebook_app_rating_page.dart';
import 'package:example/facebook/pages/facebook_app_share_page.dart';
import 'package:example/facebook/pages/facebook_archived_content_page.dart';
import 'package:example/facebook/pages/facebook_block_list_page.dart';
import 'package:example/facebook/pages/facebook_chat_detail_page.dart';
import 'package:example/facebook/pages/facebook_chat_settings_page.dart';
import 'package:example/facebook/pages/facebook_check_update_page.dart';
import 'package:example/facebook/pages/facebook_comment_reply_page.dart';
import 'package:example/facebook/pages/facebook_comments_page.dart';
import 'package:example/facebook/pages/facebook_feedback_page.dart';
import 'package:example/facebook/pages/facebook_friends_page.dart';
import 'package:example/facebook/pages/facebook_help_center_page.dart';
import 'package:example/facebook/pages/facebook_image_edit_page.dart';
import 'package:example/facebook/pages/facebook_image_preview_page.dart';
import 'package:example/facebook/pages/facebook_login_history_page.dart';
import 'package:example/facebook/pages/facebook_login_page.dart';
import 'package:example/facebook/pages/facebook_main_page.dart';
import 'package:example/facebook/pages/facebook_messenger_page.dart';
import 'package:example/facebook/pages/facebook_notifications_page.dart';
import 'package:example/facebook/pages/facebook_open_source_page.dart';
import 'package:example/facebook/pages/facebook_post_detail_page.dart';
import 'package:example/facebook/pages/facebook_post_edit_page.dart';
import 'package:example/facebook/pages/facebook_privacy_policy_page.dart';
import 'package:example/facebook/pages/facebook_product_category_page.dart';
import 'package:example/facebook/pages/facebook_product_detail_page.dart';
import 'package:example/facebook/pages/facebook_profile_edit_page.dart';
import 'package:example/facebook/pages/facebook_search_results_page.dart';
import 'package:example/facebook/pages/facebook_settings_detail_page.dart';
import 'package:example/facebook/pages/facebook_settings_page.dart';
import 'package:example/facebook/pages/facebook_story_create_page.dart';
import 'package:example/facebook/pages/facebook_story_view_page.dart';
import 'package:example/facebook/pages/facebook_update_log_page.dart';
import 'package:example/facebook/pages/facebook_user_agreement_page.dart';
import 'package:example/facebook/pages/facebook_user_profile_page.dart';
import 'package:example/facebook/pages/facebook_video_call_page.dart';
import 'package:example/facebook/pages/facebook_voice_call_page.dart';
import 'package:example/facebook/pages/facebook_register_page.dart';
import 'package:example/facebook/pages/facebook_forgot_password_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String root = '/';
  static const String main = '/main';
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
  static const String productDetail = '/product/detail';
  static const String productCategory = '/product/category';
  static const String settingsDetail = '/settings/detail';
  static const String blockList = '/settings/block-list';
  static const String archivedContent = '/settings/archived-content';
  static const String loginHistory = '/settings/login-history';
  static const String helpCenter = '/settings/help-center';
  static const String feedback = '/settings/feedback';
  static const String about = '/settings/about';
  static const String userAgreement = '/settings/user-agreement';
  static const String privacyPolicy = '/settings/privacy-policy';
  static const String openSource = '/settings/open-source';
  static const String updateLog = '/settings/update-log';
  static const String appRating = '/settings/app-rating';
  static const String appShare = '/settings/app-share';
  static const String checkUpdate = '/settings/check-update';
  static const String profileEdit = '/profile/edit';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (_) => const FacebookLoginPage(),
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => const FacebookMainPage(),
        );
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
      case productDetail:
        final product = settings.arguments! as Product;
        return MaterialPageRoute(
          builder: (_) => FacebookProductDetailPage(product: product),
        );
      case productCategory:
        final category = settings.arguments! as String;
        return MaterialPageRoute(
          builder: (_) => FacebookProductCategoryPage(category: category),
        );
      case settingsDetail:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FacebookSettingsDetailPage(
            title: args['title'] as String,
          ),
        );
      case blockList:
        return MaterialPageRoute(
          builder: (_) => const FacebookBlockListPage(),
        );
      case archivedContent:
        return MaterialPageRoute(
          builder: (_) => const FacebookArchivedContentPage(),
        );
      case loginHistory:
        return MaterialPageRoute(
          builder: (_) => const FacebookLoginHistoryPage(),
        );
      case helpCenter:
        return MaterialPageRoute(
          builder: (_) => const FacebookHelpCenterPage(),
        );
      case feedback:
        return MaterialPageRoute(
          builder: (_) => const FacebookFeedbackPage(),
        );
      case about:
        return MaterialPageRoute(
          builder: (_) => const FacebookAboutPage(),
        );
      case userAgreement:
        return MaterialPageRoute(
          builder: (_) => const FacebookUserAgreementPage(),
        );
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const FacebookPrivacyPolicyPage(),
        );
      case openSource:
        return MaterialPageRoute(
          builder: (_) => const FacebookOpenSourcePage(),
        );
      case updateLog:
        return MaterialPageRoute(
          builder: (_) => const FacebookUpdateLogPage(),
        );
      case appRating:
        return MaterialPageRoute(
          builder: (_) => const FacebookAppRatingPage(),
        );
      case appShare:
        return MaterialPageRoute(
          builder: (_) => const FacebookAppSharePage(),
        );
      case checkUpdate:
        return MaterialPageRoute(
          builder: (_) => const FacebookCheckUpdatePage(),
        );
      case profileEdit:
        return MaterialPageRoute(
          builder: (_) => const FacebookProfileEditPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const FacebookLoginPage(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const FacebookRegisterPage(),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const FacebookForgotPasswordPage(),
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

  static void toVoiceCall(
    BuildContext context, {
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

  static void toVideoCall(
    BuildContext context, {
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

  static void toChatSettings(
    BuildContext context, {
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

  static void toProductDetail(BuildContext context, Product product) {
    Navigator.pushNamed(context, productDetail, arguments: product);
  }

  static void toProductCategory(BuildContext context, String category) {
    Navigator.pushNamed(context, productCategory, arguments: category);
  }

  static void toSettingsDetail(BuildContext context, String title) {
    Navigator.pushNamed(
      context,
      settingsDetail,
      arguments: {'title': title},
    );
  }

  static void toBlockList(BuildContext context) {
    Navigator.pushNamed(context, blockList);
  }

  static void toArchivedContent(BuildContext context) {
    Navigator.pushNamed(context, archivedContent);
  }

  static void toLoginHistory(BuildContext context) {
    Navigator.pushNamed(context, loginHistory);
  }

  static void toHelpCenter(BuildContext context) {
    Navigator.pushNamed(context, helpCenter);
  }

  static void toFeedback(BuildContext context) {
    Navigator.pushNamed(context, feedback);
  }

  static void toAbout(BuildContext context) {
    Navigator.pushNamed(context, about);
  }

  static void toUserAgreement(BuildContext context) {
    Navigator.pushNamed(context, userAgreement);
  }

  static void toPrivacyPolicy(BuildContext context) {
    Navigator.pushNamed(context, privacyPolicy);
  }

  static void toOpenSource(BuildContext context) {
    Navigator.pushNamed(context, openSource);
  }

  static void toUpdateLog(BuildContext context) {
    Navigator.pushNamed(context, updateLog);
  }

  static void toAppRating(BuildContext context) {
    Navigator.pushNamed(context, appRating);
  }

  static void toAppShare(BuildContext context) {
    Navigator.pushNamed(context, appShare);
  }

  static void toCheckUpdate(BuildContext context) {
    Navigator.pushNamed(context, checkUpdate);
  }

  static void toProfileEdit(BuildContext context) {
    Navigator.pushNamed(context, profileEdit);
  }

  static void toLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      login,
      (route) => false,
    );
  }

  static void toMain(BuildContext context) {
    // 清除所有路由并导航到主页
    Navigator.pushNamedAndRemoveUntil(
      context, 
      main,
      (route) => false,
    );
  }

  static void toRegister(BuildContext context) {
    Navigator.pushNamed(context, register);
  }

  static void toForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, forgotPassword);
  }
}
