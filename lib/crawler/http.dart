part of '../main.dart';

class MyHttpClient {
  static Future init() async {
    final userAgent =
        "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Mobile Safari/537.36";

    final ioClient = new HttpClient()
      ..badCertificateCallback = (_, __, ___) => true;
    ioClient.userAgent = userAgent;
    final client = IOClient(ioClient);
    HttpHanManJia(client);
  }
}

abstract class UserAgentClient extends http.BaseClient {
  final http.Client inner;

  UserAgentClient(this.inner);

  Future<List<Book>> searchBook(String name);

  Future<Book> getBook(String aid);

  Future<List<String>> getChapterImages(Book book, Chapter chapter);
}
