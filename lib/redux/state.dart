import '../model/gallery.dart';

class AppState {
  final List<Gallery> _galleryList;
  final int _page;
  int? _currentIndex;

  AppState(this._galleryList, this._page, this._currentIndex);
  AppState.init(List<Gallery> galleryList, int page)
      : this(galleryList, page, null);

  AppState.initialState()
      : _galleryList = List.empty(),
        _page = 1;

  AppState.copy(AppState state, int index)
      : _galleryList = state.galleryList,
        _page = state.page,
        _currentIndex = index;

  List<Gallery> get galleryList => _galleryList;

  int get page => _page;

  int? get currentIndex => _currentIndex;
}
