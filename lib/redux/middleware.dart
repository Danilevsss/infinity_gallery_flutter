import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/gallery.dart';
import '../redux/actions.dart';
import '../redux/state.dart';
import '../repository/repository.dart';

final Repository repository = Repository.getInstance();

ThunkAction<AppState> loadNextPage = (Store<AppState> store) async {
  List<Gallery> gallery = await repository.nextPage(store.state.page);
  List<Gallery> result = [];
  result.addAll(store.state.galleryList);
  result.addAll(gallery);
  store.dispatch(LoadGalleryAction(result, store.state.page + 1));
};
