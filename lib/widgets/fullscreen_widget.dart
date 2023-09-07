import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../model/gallery.dart';
import '../redux/actions.dart';
import '../redux/state.dart';

class FullscreenWidget extends StatefulWidget {
  const FullscreenWidget({super.key});

  @override
  State<StatefulWidget> createState() => _FullScreenPhotoState();
}

class _FullScreenPhotoState extends State {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          Gallery gallery = state.galleryList[state.currentIndex!];
          return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: Text(gallery.user.name),
              ),
              body: Center(
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () => {
                                    _likePressed(
                                        context, gallery, state.currentIndex!)
                                  },
                              icon: Icon(gallery.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border))
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  Future _likePressed(context, Gallery gallery, int currentIndex) async {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(LikePressedAction(gallery, currentIndex));
  }
}
