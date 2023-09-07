import '../model/gallery.dart';
import 'actions.dart';
import 'state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is LoadGalleryAction) {
    return _loadGallery(action);
  }
  if (action is LikePressedAction) {
    return _likePressed(state, action);
  }
  if (action is OpenFullscreenAction) {
    return _openFullscreen(state, action);
  }
  return state;
}

AppState _loadGallery(LoadGalleryAction action) {
  return AppState.init(action.galleryList, action.page);
}

AppState _likePressed(AppState state, LikePressedAction action) {
  List<Gallery> result = List.from(state.galleryList);
  Gallery gallery = Gallery(action.gallery.id, action.gallery.urls,
      action.gallery.user, !action.gallery.isLiked);
  result[action.index] = gallery;
  return AppState(result, state.page, state.currentIndex);
}

AppState _openFullscreen(AppState state, OpenFullscreenAction action) {
  return AppState.copy(state, action.index);
}
