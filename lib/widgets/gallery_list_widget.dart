import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/middleware.dart';
import '../redux/state.dart';
import 'gallery_card_widget.dart';

class GalleryListWidget extends StatefulWidget {
  const GalleryListWidget({super.key});

  @override
  State<StatefulWidget> createState() => GalleryListState();
}

class GalleryListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Infinity Gallery"),
        ),
        body: Center(
            child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              Expanded(
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (_, state) {
                    var store = StoreProvider.of<AppState>(context);
                    if (state.galleryList.isEmpty) {
                      store.dispatch(loadNextPage);
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.galleryList.length,
                        itemBuilder: (context, index) {
                          if (index == state.galleryList.length - 1) {
                            store.dispatch(loadNextPage);
                          }
                          return GestureDetector(
                            child: GalleryCardWidget(
                                state.galleryList[index], index),
                          );
                        });
                  },
                ),
              )
            ]))));
    //
  }
}
