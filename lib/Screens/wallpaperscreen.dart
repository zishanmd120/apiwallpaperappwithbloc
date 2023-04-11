import 'package:apiwallpaperappwithbloc/Models/wallpapermodel.dart';
import 'package:apiwallpaperappwithbloc/Utils/constants.dart';
import 'package:apiwallpaperappwithbloc/Utils/snackbar.dart';
import 'package:apiwallpaperappwithbloc/Widgets/imagecard.dart';
import 'package:apiwallpaperappwithbloc/Widgets/loading.dart';
import 'package:apiwallpaperappwithbloc/Widgets/notfound.dart';
import 'package:apiwallpaperappwithbloc/cubit/wallpaper_cubit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({Key? key}) : super(key: key);

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: creamWhite,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: black,
      ),
      body: Column(
        children: [
          const Text(
            'Creative XPress',
            style: TextStyle(fontSize: 40, fontFamily: handlee),
          ),
          Neumorphic(
            child: TextField(
              onSubmitted: (value) =>
                  context.read<WallpaperCubit>().getWallpapers(value),
              controller: _controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: InputBorder.none,
                hintText: 'Search Wallpaper',
                hintStyle: const TextStyle(color: grey),
                suffixIcon: ElevatedButton(
                  child: const Icon(Icons.search),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<WallpaperCubit>()
                        .getWallpapers(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<WallpaperCubit, WallpaperState>(
              listener: (context, state) {
                if (state is WallpaperError) {
                  Snackbar.show(
                      context, 'Unable to get wallpapers', ContentType.failure);
                }
              },
              builder: (context, state) {
                if (state is WallpaperLoading) {
                  return const LoadingIndicator();
                } else if (state is WallpaperError) {
                  return const NotFoundIllustration();
                }
                List<WallpaperModel> wallpapers = [];
                if (state is WallpaperLoaded) {
                  wallpapers = state.wallpapers;
                } else {
                  wallpapers = context.read<WallpaperCubit>().wallpapers;
                }

                return MasonryGridView.count(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  itemBuilder: (_, index) =>
                      ImageCard(wallpaper: wallpapers[index]),
                  itemCount: wallpapers.length,
                );
              },
            ),
          ),
          // Expanded(
          //   child: BlocConsumer(
          //       builder: (_,state){
          //         if(state is WallpaperLoading){
          //           return Center(child: CircularProgressIndicator());
          //         } else {
          //           return MasonryGridView.count(
          //             itemCount: (state as WallpaperLoaded).wallpapers.length,
          //               crossAxisCount: 2,
          //               mainAxisSpacing: 2,
          //               crossAxisSpacing: 2,
          //               itemBuilder: (_,index){
          //                 return Container(
          //                   height: 100,
          //                   color: Colors.black,
          //                 );
          //               }
          //           );
          //         }
          //       },
          //       listener: (_,state){}
          //   ),
          // )
        ],
      ),
    );
  }
}
