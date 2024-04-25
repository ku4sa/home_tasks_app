enum AppRoute {
  home('/homepage'),
  settings('/settings'),
  auth('/auth'),
  plans('/plans'),
  test('/test'),
  groupes('/homepage/groupes'),
  group('/homepage/groupes/group'),
  userAdd('/homepage/groupes/group/user');

  const AppRoute(this.path);
  final String path;
}
