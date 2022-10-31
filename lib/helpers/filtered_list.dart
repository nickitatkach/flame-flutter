class FilteredList<T> {
  FilteredList(List<T>? _items, int? _count)
      : items = _items,
        count = _count;

  List<T>? items;
  int? count;
}