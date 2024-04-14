enum AppRoute {
  home('/homepage'),
  settings('/settings'),
  auth('/auth'),
  plans('/plans'),
  ;

  const AppRoute(this.path);
  final String path;
}
