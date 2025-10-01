import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

class OpenNewsInBrowserEvent extends NewsEvent {
  final String url;
  OpenNewsInBrowserEvent(this.url);
}

class ChangeDateFormatEvent extends NewsEvent {
  final String publishedAt;
  ChangeDateFormatEvent(this.publishedAt);
}
