part of 'main.dart';

final weekTime = Duration.millisecondsPerDay * 7;

void openBook(BuildContext context, Book book, String heroTag) {
  print('openBook ${book.name} version:${book.version}');
  if (book.version == 0 || book.version == null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/activity_search/${book.name}'),
        builder: (_) => ActivitySearch(search: book.name),
      ),
    );
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: '/activity_book/${book.name}'),
      builder: (_) => ActivityBook(book: book, heroTag: heroTag),
    ),
  );
}

void openChapter(BuildContext context, Book book, Chapter chapter) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
          name: '/activity_chapter/${book.name}/${chapter.cname}'),
      builder: (_) => ActivityChapter(book, chapter),
    ),
  );
}
