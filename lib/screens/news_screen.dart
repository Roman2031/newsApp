import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:news_app/bloc/news_bloc_bloc.dart';
import 'package:news_app/bloc/news_bloc_event.dart';
import 'package:news_app/bloc/news_bloc_state.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(NewsRepository())..add(FetchNewsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text('News App'))),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NewsBloc>().add(FetchNewsEvent());
                },
                child: ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (_, index) {
                    final article = state.articles[index];
                    return ListTile(
                      onTap: () {
                        context.read<NewsBloc>().add(
                          OpenNewsInBrowserEvent(article.url),
                        );
                      },
                      leading: article.urlToImage != null
                          ? Image.network(
                              article.urlToImage!,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image, size: 100),
                      title: Text(article.title),
                      subtitle: Text(
                        DateFormat(
                          'dd-MMM-yyyy',
                        ).format(DateTime.parse(article.publishedAt)),
                      ),
                    );
                  },
                ),
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No news yet.'));
            }
          },
        ),
      ),
    );
  }
}
