import 'package:flutter/material.dart';

enum IconName {
  profileUser1,
  profileUser2,
  profileUser3,
  profileUser4,
  profileUser5,
  profileUser6,
  profileStaff1,
  profileStaff2,
  profileStaff3,
  profileStaff4,
  profileStaff5,
  profileStaff6,
  bottomBarIconChat,
  bottomBarIconCommunity,
  bottomBarIconNote,
  bottomBarIconBooking,
  help1,
  help2,
  help3,
  help4,
  theme1,
  theme2,
  theme3,
  theme4,
  theme5
}

class CustomIcon extends StatelessWidget {
  final IconName name;
  final double? width;
  final double? height;
  final Color? color;
  const CustomIcon(this.name, {this.width, this.height, this.color, super.key});

  Widget _pngImage(String path) {
    return Image.asset('assets/images/$path.png', width: width, height: height, color: color);
  }

  @override
  Widget build(BuildContext context) {
    switch (name) {
      case IconName.profileUser1:
        return _pngImage('profile1');

      case IconName.profileUser2:
        return _pngImage('profile2');

      case IconName.profileUser3:
        return _pngImage('profile3');

      case IconName.profileUser4:
        return _pngImage('profile4');

      case IconName.profileUser5:
        return _pngImage('profile4');

      case IconName.profileUser6:
        return _pngImage('profile6');

      case IconName.profileStaff1:
        return _pngImage('profile7');

      case IconName.profileStaff2:
        return _pngImage('profile8');

      case IconName.profileStaff3:
        return _pngImage('profile9');

      case IconName.profileStaff4:
        return _pngImage('profile10');

      case IconName.profileStaff5:
        return _pngImage('profile11');

      case IconName.profileStaff6:
        return _pngImage('profile12');

      case IconName.bottomBarIconChat:
        return _pngImage('chat_icon');

      case IconName.bottomBarIconNote:
        return _pngImage('note_icon');

      case IconName.bottomBarIconBooking:
        return _pngImage('calendar_icon');

      case IconName.bottomBarIconCommunity:
        return _pngImage('comminity_icon');

      case IconName.help1:
        return _pngImage('help1');

      case IconName.help2:
        return _pngImage('help2');

      case IconName.help3:
        return _pngImage('help3');

      case IconName.help4:
        return _pngImage('help4');
        
      case IconName.theme1:
        return _pngImage('theme1');

      case IconName.theme2:
        return _pngImage('theme2');

      case IconName.theme3:
        return _pngImage('theme3');

      case IconName.theme4:
        return _pngImage('theme4');

      case IconName.theme5:
        return _pngImage('theme5');

      default:
        return Container();
    }
  }
}
