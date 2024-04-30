import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/repositories/group_repository.dart';
import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/repositories/models/task_type/task_type.dart';
import 'package:home_tasks_app/repositories/utils/validator.dart';
import 'package:home_tasks_app/theme/theme.dart';
import 'package:home_tasks_app/view/components/priority_view.dart';
import 'package:home_tasks_app/view/task_selecter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../../repositories/models/status/status.dart';
import '../../repositories/models/user/user.dart';
import '../components/components.dart';
import '../components/text_field.dart';
import 'task_page_bloc.dart';
import 'task_page_events.dart';
import 'task_page_state.dart';

class TaskEditor extends StatefulWidget {
  final Task? task;

  const TaskEditor({
    super.key,
    this.task,
  });

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  late final TaskEditorPageBloc bloc;
  late TextEditingController nameController;
  late TextEditingController describtionController;
  late TextEditingController leadTimeController;
  final users = GetIt.instance<GroupRepository>().getUsers();
  @override
  void initState() {
    nameController = TextEditingController(text: widget.task?.name);
    describtionController =
        TextEditingController(text: widget.task?.describtion);
    leadTimeController = TextEditingController(
        text: widget.task?.leadTime != null
            ? widget.task!.leadTime.toString()
            : "0");
    bloc = TaskEditorPageBloc();
    (widget.task == null)
        ? bloc.add(CreatorOpened())
        : bloc.add(
            EditorOpened(task: widget.task!),
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
          child: BlocBuilder<TaskEditorPageBloc, TaskEditorPageState>(
            bloc: bloc,
            builder: (context, state) => MyAppBar(
              canGoBack: true,
              title: widget.task == null
                  ? 'Создание задачи'
                  : 'Редактирование задачи',
              onExit: () {
                context.pop(bloc.changeData.value);
              },
              righttExitWithSave: true,
              onExitWithSave: state.isValid
                  ? () {
                      context.pop(state.task);
                    }
                  : null,
              haveButtons: false,
            ),
          ),
        ),
        body: BlocListener<TaskEditorPageBloc, TaskEditorPageState>(
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
                      if (widget.task == null)
                        ImportButton(
                          onTap: () async {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => const TaskSelecter(),
                            ).then(
                              (value) {
                                if (value != null && value is Task) {
                                  bloc.add(
                                    ImportSettings(
                                      task: value,
                                    ),
                                  );
                                  setState(
                                    () {
                                      nameController.value =
                                          TextEditingValue(text: value.name);
                                      describtionController.value =
                                          TextEditingValue(
                                              text: value.describtion ?? '');
                                      leadTimeController.value =
                                          TextEditingValue(
                                        text: value.leadTime != null
                                            ? value.leadTime.toString()
                                            : "0",
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                      _textLabel('Название задачи:'),
                      BlocBuilder<TaskEditorPageBloc, TaskEditorPageState>(
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
                      _textLabel("Описание задачи"),
                      BlocBuilder<TaskEditorPageBloc, TaskEditorPageState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: 100,
                            child: MyCustomTextField(
                              controller: describtionController,
                              readOnly: false,
                              maxLines: 3,
                              validator: (p0) =>
                                  Validator.validateDescription(p0),
                              //initialValue: state.task?.describtion,
                              label: '',
                              hInt: '',
                              onChanged: (p0) {
                                bloc.add(ChangeDescribtion(describtion: p0));
                              },
                            ),
                          );
                        },
                      ),
                      if (users != null && users!.isNotEmpty)
                        _textLabel("Исполнитель"),
                      if (users != null && users!.isNotEmpty)
                        SizedBox(
                          width: 400,
                          child: MyDropDownButton(
                            content: users!,
                            haveBorder: true,
                            selectedValue: widget.task?.user != null
                                ? User(username: widget.task!.user!)
                                : null,
                            onChanged: (value) {
                              if (value is User) {
                                bloc.add(ChangeActiveUser(user: value));
                              }
                            },
                          ),
                        ),
                      _textLabel("Статус:"),
                      MyDropDownButton(
                        content: [
                          Status(status: 1),
                          Status(status: 2),
                          Status(status: 3),
                        ],
                        setDefault: true,
                        haveBorder: true,
                        selectedValue: widget.task?.getStatus(),
                        onChanged: (value) {
                          if (value is Status) {
                            bloc.add(ChangeStatus(status: value));
                          }
                        },
                      ),
                      _textLabel("Тип задачи:"),
                      MyDropDownButton(
                        content: [
                          TaskType(type: 1),
                          TaskType(type: 2),
                        ],
                        setDefault: true,
                        haveBorder: true,
                        selectedValue: widget.task?.getType(),
                        onChanged: (value) {
                          if (value is TaskType) {
                            bloc.add(ChangeTaskType(type: value));
                          }
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: bloc.selectedType,
                        builder: (context, value, child) {
                          final type = value?.type;
                          switch (type) {
                            case 1:
                              return _scrollDatePicker();
                            case 2:
                              return _intervalChoiser();
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: PriorityView(
                                priority: widget.task?.priority,
                                onChanged: (value) {
                                  bloc.add(
                                    ChangePriority(
                                      priority: value,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _textLabel("Время выполнения:"),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: MyCustomTextField(
                                            readOnly: false,
                                            validator: (value) =>
                                                Validator.validateLeadTime(
                                              value,
                                            ),
                                            controller: leadTimeController,
                                            label: "",
                                            textAlign: TextAlign.center,
                                            hInt: 'минуты на выполнение',
                                            onChanged: (value) {
                                              bloc.add(
                                                ChangeLeadTime(time: value),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Center(
                                                child: _textLabel("минут")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choiser({
    required String name,
    required Widget wheelChoiser,
    required double widthBorder,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: AppTextStyles.headerName,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: widthBorder,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.lightBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                wheelChoiser,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollDatePicker() {
    print('build scroll datePicker');
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textLabel("Выполнить до:"),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.darkBlue,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 35,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: bloc.selectedDate,
                  builder: (context, value, child) => ScrollDatePicker(
                    //indicator: SizedBox(),
                    indicator: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 35,
                    ),
                    onDateTimeChanged: (value) {
                      bloc.add(ChangeDate(time: value));
                    },
                    options: DatePickerOptions(
                      isLoop: true,
                      backgroundColor: AppColors.darkWhite,
                      itemExtent: 20,
                      diameterRatio: 1,
                      perspective: 0.001,
                    ),
                    scrollViewOptions: const DatePickerScrollViewOptions(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    minimumDate: widget.task?.date ?? DateTime.now(),
                    maximumDate:
                        DateTime.now().add(const Duration(days: 365 * 50)),
                    selectedDate: value ?? DateTime.now(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intervalChoiser() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.darkWhite,
        ),
        height: 140,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _choiser(
                name: "Каждые:",
                wheelChoiser: WheelChooser.integer(
                  onValueChanged: (value) {
                    if (value is int) {
                      bloc.add(ChangeInterval(interval: value));
                    }
                    print(value);
                  },
                  maxValue: 30,
                  initValue: 3,
                  minValue: 1,
                ),
                widthBorder: 50),
            _choiser(
                name: "Величина:",
                wheelChoiser: WheelChooser.choices(
                  startPosition: 0,
                  choices: [
                    WheelChoice(value: 1, title: "день"),
                    WheelChoice(value: 7, title: "неделя"),
                    WheelChoice(value: 30, title: "месяц"),
                    WheelChoice(value: 365, title: "год")
                  ],
                  onChoiceChanged: (value) {
                    if (value is int) {
                      bloc.add(
                        ChangeInterval(type: value),
                      );
                    }
                  },
                ),
                widthBorder: 100)
          ],
        ),
      ),
    );
  }

  Widget _textLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: AppTextStyles.bigText.copyWith(
          height: 1,
        ),
      ),
    );
  }
}
