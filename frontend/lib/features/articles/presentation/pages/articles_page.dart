
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symmetryproject/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:symmetryproject/features/articles/presentation/bloc/articles_event.dart';
import 'package:symmetryproject/features/articles/presentation/bloc/articles_state.dart';
import 'package:symmetryproject/features/articles/presentation/pages/add_article_page.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/article.dart';
import '../widgets/article_card.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily News'),centerTitle: true,actions: const [
        Icon(Icons.bookmark)
      ],),
      body: const ArticlesView(),
      floatingActionButton: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: FloatingActionButton(
              onPressed: ()async{
                await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddArticlePage()),
  ).then((value) => context.read<ArticlesBloc>().add(FetchArticles()));
              },backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),),
          );
        }
      ),
    );
  }
}

class ArticlesView extends StatelessWidget {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ArticlesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ArticlesBloc>().add(FetchArticles());
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: _buildArticleList(context, state.articles),
          );
        } else if (state is ArticlesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load articles',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(state.message),
                TextButton(
                  onPressed: () => context.read<ArticlesBloc>().add(FetchArticles()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          // ArticlesInitial — shouldn't show if we auto-fetch
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildArticleList(BuildContext context, List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleCard(article: article,index: index,);
      },
    );
  }
}

