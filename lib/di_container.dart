import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository_firebase.dart';

void setupDi() {
  GetIt.I.registerLazySingleton<CatsRepository>(CatsRepositoryFirebase.new);
}
