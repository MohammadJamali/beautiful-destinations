extension StringExtension on Map<String, String> {
  String? encodeQueryParameters() {
    return entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
