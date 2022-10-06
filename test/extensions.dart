extension MapExtensions on num {
  List<T> map<T>(T Function(int) invoke) {
    return List.generate(toInt(), (index) => invoke(index));
  }
}
