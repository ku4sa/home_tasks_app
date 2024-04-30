enum AppRoute {
  home('/homepage'),
  settings('/settings'),
  auth('/auth'),
  plans('/plans'),
  test('/test'),
  groupes('/homepage/groupes'),
  group('/homepage/groupes/group'),
  room('/homepage/groupes/room'),
  tasks('/homepage/groupes/room/tasks'),
  task('/homepage/groupes/room/tasks/task'),
  userAdd('/homepage/groupes/group/user');

  const AppRoute(this.path);
  final String path;
}
