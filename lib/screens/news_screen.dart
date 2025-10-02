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
        appBar: AppBar(title: const Center(child: Text('News App', style: TextStyle(fontWeight: FontWeight.w400),))),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NewsBloc>().add(FetchNewsEvent());
                },
                child: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (_, index) {
                      final article = state.articles[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<NewsBloc>().add(
                            OpenNewsInBrowserEvent(article.url),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.urlToImage != null)
                                Container(
                                  margin: const EdgeInsets.all(16.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(article.urlToImage!),
                                  ),
                                )
                              else
                                const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.image,
                                        size: 200,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      DateFormat('dd-MMM-yyyy').format(
                                        DateTime.parse(article.publishedAt),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Icon(
                                      Icons.bookmark_border,
                                      size: 25,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
