// import 'package:flutter/material.dart';

// class AvatarProfile extends StatelessWidget {
//   const AvatarProfile({
//     super.key,
//     required this.imagePath,
//     required this.width,
//     required this.height,
//   });

//   final String imagePath;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 45,
//       child: ClipOval(
//         child: Image.asset(
//           imagePath,
//           width: width,
//           height: height,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xffc9c9c9), width: 1),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
