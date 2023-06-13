class Host {
  String host;
  bool https = false;
  Host({required this.host, required this.https});
  Uri getUri(String path, [Map<String, dynamic>? queryParameters]) {
    return Uri(
      host: host,
      scheme: this.https ? 'https' : 'http',
      port: this.https ? 3001 : 3000,
      path: path,
      queryParameters: queryParameters,
    );
  }
}
