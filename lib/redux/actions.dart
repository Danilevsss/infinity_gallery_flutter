import '../model/gallery.dart';

class LoadGalleryAction {
  final List<Gallery> _galleryList;
  final int _page;

  LoadGalleryAction(this._galleryList, this._page);

  int get page => _page;

  List<Gallery> get galleryList => _galleryList;
}

class LikePressedAction {
  final Gallery _gallery;
  final int _index;

  LikePressedAction(this._gallery, this._index);

  int get index => _index;

  Gallery get gallery => _gallery;
}

class OpenFullscreenAction {
  final int _index;

  OpenFullscreenAction(this._index);

  int get index => _index;
}
