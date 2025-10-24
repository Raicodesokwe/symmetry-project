// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/network/network_info.dart' as _i7;
import 'core/network/network_module.dart' as _i13;
import 'features/articles/data/datasources/article_local_data_source.dart'
    as _i3;
import 'features/articles/data/repositories/article_repository_impl.dart'
    as _i9;
import 'features/articles/domain/repositories/article_repository.dart' as _i8;
import 'features/articles/domain/usecases/add_article.dart' as _i11;
import 'features/articles/domain/usecases/get_articles.dart' as _i10;
import 'features/articles/presentation/bloc/add_article_bloc.dart' as _i12;
import 'injection.dart' as _i14;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final networkModule = _$NetworkModule();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.ArticleLocalDataSource>(
      () => _i3.ArticleLocalDataSource());
  gh.lazySingleton<_i4.Connectivity>(() => networkModule.connectivity);
  gh.lazySingleton<_i5.FirebaseStorage>(
    () => firebaseModule.storage,
    instanceName: 'storage',
  );
  gh.lazySingleton<_i6.FirebaseFirestore>(
    () => firebaseModule.firestore,
    instanceName: 'firestore',
  );
  gh.lazySingleton<_i7.NetworkInfo>(
      () => _i7.NetworkInfoImpl(gh<_i4.Connectivity>()));
  gh.lazySingleton<_i8.ArticleRepository>(() => _i9.ArticleRepositoryImpl(
        localDataSource: gh<_i3.ArticleLocalDataSource>(),
        firestore: gh<_i6.FirebaseFirestore>(instanceName: 'firestore'),
        storage: gh<_i5.FirebaseStorage>(instanceName: 'storage'),
        networkInfo: gh<_i7.NetworkInfo>(),
      ));
  gh.lazySingleton<_i10.GetArticles>(
      () => _i10.GetArticles(gh<_i8.ArticleRepository>()));
  gh.factory<_i11.AddArticle>(
      () => _i11.AddArticle(gh<_i8.ArticleRepository>()));
  gh.factory<_i12.AddArticleBloc>(
      () => _i12.AddArticleBloc(gh<_i11.AddArticle>()));
  return getIt;
}

class _$NetworkModule extends _i13.NetworkModule {}

class _$FirebaseModule extends _i14.FirebaseModule {}
