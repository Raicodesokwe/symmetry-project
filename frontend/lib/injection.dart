import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies(){
  init(getIt);
}
@module
abstract class FirebaseModule {
  @lazySingleton
  @Named('firestore')
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  @Named('storage')
  FirebaseStorage get storage => FirebaseStorage.instance;
}
