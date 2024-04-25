import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/utils/validator.dart';
import 'package:home_tasks_app/theme/theme.dart';
import 'package:home_tasks_app/view/group_page/group_page_events.dart';
import 'package:home_tasks_app/view/group_selecter.dart';
import '../components/components.dart';
import '../components/text_field.dart';
import 'group_page_bloc.dart';
import 'group_page_state.dart';

class GroupEditor extends StatefulWidget {
  final GroupOfRooms? group;
  const GroupEditor({
    super.key,
    this.group,
  });

  @override
  State<GroupEditor> createState() => _GroupEditorState();
}

class _GroupEditorState extends State<GroupEditor> {
  late final GroupEditorPageBloc bloc;
  late String name;
  late String describtion;
  @override
  void initState() {
    bloc = GroupEditorPageBloc();
    (widget.group == null)
        ? bloc.add(CreatorOpened())
        : bloc.add(
            EditorOpened(group: widget.group!),
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: AppColors.darkWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            canGoBack: true,
            title: widget.group == null
                ? 'Создание помещения'
                : 'Редактирование помещения',
            onExit: () {
              context.pop(bloc.changeData.value);
            },
            haveAddButton: true,
            onExitWithSave: () {
              context.pop(bloc.state.group);
            },
            haveButtons: false,
          ),
        ),
        body: BlocListener<GroupEditorPageBloc, GroupEditorPageState>(
          listener: (context, state) {
            if (bloc.state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.group == null)
                        ImportButton(
                          onTap: () async {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => const GroupSelecter(),
                            ).then(
                              (value) {
                                if (value != null && value is GroupOfRooms) {
                                  bloc.add(ImportSettings(group: value));
                                }
                              },
                            );
                          },
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Название помещения:',
                        style: AppTextStyles.bigText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<GroupEditorPageBloc, GroupEditorPageState>(
                        builder: (context, state) => CustomTextField(
                          initialValue: state.group?.name,
                          label: '',
                          hInt: '',
                          onChanged: (p0) {
                            bloc.add(ChangeName(name: p0));
                          },
                          formzInput: state.name,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Описание помещения:',
                        style: AppTextStyles.bigText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<GroupEditorPageBloc, GroupEditorPageState>(
                          builder: (context, state) {
                        print('build');
                        return SizedBox(
                          height: 100,
                          child: CustomTextField(
                            maxLines: 3,
                            initialValue: state.group?.describtion,
                            label: '',
                            formzInput: state.describtion,
                            hInt: '',
                            onChanged: (p0) {
                              bloc.add(ChangeDescribtion(describtion: p0));
                            },
                          ),
                        );
                      }),
                      if (widget.group != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: LabelWithAdd(
                              label: 'Доступ к помещению :',
                              onAdd: () async {
                                final user = await showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => const FindUser(),
                                );

                                if (user is String) {
                                  bloc.add(
                                    AddUser(
                                      username: user,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<GroupEditorPageBloc, GroupEditorPageState>(
                builder: (context, state) => SliverList.builder(
                  itemCount:
                      state.group != null ? state.group!.users.length : 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 5),
                      child: ListItem(
                        label: state.group!.users[index],
                        onTap: () {
                          bloc.add(
                            DeleteUser(
                              username: state.group!.users[index],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
