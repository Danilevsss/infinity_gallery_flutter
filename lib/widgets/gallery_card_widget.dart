import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';
import '../widgets/fullscreen_widget.dart';
import '../model/gallery.dart';
import '../redux/state.dart';

class GalleryCardWidget extends StatelessWidget {
  final Gallery gallery;
  final int photoIndex;

  const GalleryCardWidget(this.gallery, this.photoIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      splashColor: Colors.grey,
      onTap: () => _openFullScreenPhoto(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: gallery.urls.regular,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(gallery.user.name,
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
                const Spacer(),
                IconButton(
                    onPressed: () =>
                        {_likePressed(context, gallery, photoIndex)},
                    icon: Icon(gallery.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border))
              ],
            ),
          ),
          const Divider()
        ],
      ),
    ));
  }

  Future _likePressed(context, Gallery gallery, int currentIndex) async {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(LikePressedAction(gallery, currentIndex));
  }

  void _openFullScreenPhoto(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(OpenFullscreenAction(photoIndex));
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FullscreenWidget()));
  }
}
