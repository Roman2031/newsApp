import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/bloc/news_bloc_event.dart';
import 'package:news_app/bloc/news_bloc_state.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<OpenNewsInBrowserEvent>(_onOpenArticleUrl);

    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await repository.fetchNews();
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }

  Future<void> _onOpenArticleUrl(
    OpenNewsInBrowserEvent event,
    Emitter<NewsState> emit,
  ) async {
    final url = Uri.parse(event.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
