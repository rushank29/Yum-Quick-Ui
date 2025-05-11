class ItemKeyValuePair {
  final String title;
  final String value;
  final bool showDivider;

  ItemKeyValuePair({
    required this.title,
    required this.value,
    this.showDivider = false,
  });
}