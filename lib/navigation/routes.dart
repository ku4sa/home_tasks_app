enum AppRoute {
  home('/homepage'),
  settings('/settings'),
  auth('/auth'),
  favorites('/plans'),
  ;

  const AppRoute(this.path);
  final String path;
}
