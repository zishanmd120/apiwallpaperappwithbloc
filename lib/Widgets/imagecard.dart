import 'package:apiwallpaperappwithbloc/Models/wallpapermodel.dart';
import 'package:apiwallpaperappwithbloc/Screens/setwallpaperscreen.dart';
import 'package:apiwallpaperappwithbloc/Utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ImageCard extends StatelessWidget {
  final WallpaperModel wallpaper;

  const ImageCard({Key? key, required this.wallpaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        depth: 5,
        color: creamWhite,
        shadowLightColor: white,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SetWallpaperScreen(wallpaper: wallpaper),
              ),
            );
          },
          child: Image.network(
            wallpaper.thumbnail,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
