import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';
import 'package:home_tasks_app/repositories/utils/validator.dart';
import 'package:home_tasks_app/theme/theme.dart';
import 'package:home_tasks_app/view/room_page/room_page_events.dart';
import '../components/components.dart';
import '../components/text_field.dart';
import '../room_selecter.dart';
import 'room_page_bloc.dart';
import 'room_page_state.dart';

class RoomEditor extends StatefulWidget {
  final Room? room;
  // final bool fullEdittingMode;
  const RoomEditor({
    super.key,
    this.room, //this.fullEdittingMode = true
  });

  @override
  State<RoomEditor> createState() => _RoomEditorState();
}

class _RoomEditorState extends State<RoomEditor> {
  late final RoomEditorPageBloc bloc;
  late TextEditingController nameController;
  late TextEditingController describtionController;
  @override
  void initState() {
    nameController = TextEditingController(text: widget.room?.name);
    describtionController =
        TextEditingController(text: widget.room?.describtion);
    bloc = RoomEditorPageBloc();
    (widget.room == null)
        ? bloc.add(CreatorOpened())
        : bloc.add(
            EditorOpened(room: widget.room!),
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
            title: widget.room == null
                ? 'Создание Комнаты'
                : 'Редактирование комнаты',
            onExit: () {
              context.pop(bloc.changeData.value);
            },
            righttExitWithSave: true,
            onExitWithSave: () {
              context.pop(bloc.state.room);
            },
            haveButtons: false,
          ),
        ),
        body: BlocListener<RoomEditorPageBloc, RoomEditorPageState>(
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
                      if (widget.room == null)
                        ImportButton(
                          onTap: () async {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => const RoomSelecter(),
                            ).then(
                              (value) {
                                if (value != null && value is Room) {
                                  bloc.add(ImportSettings(room: value));
                                  setState(() {
                                    nameController.value =
                                        TextEditingValue(text: value.name);
                                    describtionController.value =
                                        TextEditingValue(
                                            text: value.describtion ?? '');
                                  });
                                }
                              },
                            );
                          },
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Название комнаты:',
                        style: AppTextStyles.bigText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<RoomEditorPageBloc, RoomEditorPageState>(
                        builder: (context, state) => MyCustomTextField(
                          controller: nameController,
                          readOnly: false,
                          label: '',
                          validator: (p0) => Validator.validateName(p0),
                          hInt: '',
                          onChanged: (p0) {
                            bloc.add(ChangeName(name: p0));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Описание комнаты:',
                        style: AppTextStyles.bigText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<RoomEditorPageBloc, RoomEditorPageState>(
                        builder: (context, state) {
                          print('build');
                          return SizedBox(
                            height: 100,
                            child: MyCustomTextField(
                              controller: describtionController,
                              readOnly: false,
                              maxLines: 3,
                              validator: (p0) =>
                                  Validator.validateDescription(p0),
                              initialValue: state.room?.describtion,
                              label: '',
                              hInt: '',
                              onChanged: (p0) {
                                bloc.add(ChangeDescribtion(describtion: p0));
                              },
                            ),
                          );
                        },
                      ),
                      /*  if (widget.room != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: LabelWithAdd(
                              label: 'Доступ к помещению :',
                              onAdd: widget.fullEdittingMode
                                  ? () async {
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
                                    }
                                  : null,
                            ),
                          ),
                        ),*/
                    ],
                  ),
                ),
              ),
              /* BlocBuilder<RoomEditorPageBloc, RoomEditorPageState>(
                builder: (context, state) => SliverList.builder(
                  itemCount: state.room != null ? state.room!.users.length : 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 5),
                      child: ListItem(
                        label: state.room!.users[index],
                        onTap: widget.fullEdittingMode
                            ? () {
                                bloc.add(
                                  DeleteUser(
                                    username: state.room!.users[index],
                                  ),
                                );
                              }
                            : state.room!.users[index] ==
                                    GetIt.instance<AuthorizationRepository>()
                                        .activeUser
                                        .value!
                                        .username
                                ? () {
                                    bloc.add(
                                      DeleteUser(
                                        username: state.room!.users[index],
                                      ),
                                    );
                                  }
                                : null,
                      ),
                    );
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
