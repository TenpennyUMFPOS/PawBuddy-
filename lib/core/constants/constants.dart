import 'package:flutter/cupertino.dart';
import 'package:project_integration_pb/features/feed/feed_screen.dart';

import '../../features/post/screens/add_post_screen.dart';

class Constants {
  static const googlePath = 'assets/images/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://png.pngtree.com/png-clipart/20220121/ourlarge/pngtree-cartoon-hand-drawn-default-avatar-cat-png-image_4278361.png';
  static const tabWidgets = [
    FeedScreen(),
    AddPostScreen(),
  ];
  static const IconData up = IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down = IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };

}