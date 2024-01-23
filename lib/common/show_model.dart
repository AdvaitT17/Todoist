import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoist/constants/app_style.dart';
import 'package:todoist/model/todo_model.dart';
import 'package:todoist/provider/date_time_provider.dart';
import 'package:todoist/provider/radio_provider.dart';
import 'package:todoist/provider/service_provider.dart';
import 'package:todoist/widget/date_time_widget.dart';
import 'package:todoist/widget/radio_widget.dart';
import 'package:todoist/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
   AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Todo Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12), 
          const Text('Task Title', style: AppStyle.headingOne,),
          const Gap(6),
          TextFieldWidget(maxLine: 1, hintText: 'Name of the task', txtController: titleController,),
          Gap(12),
          Text('Description', style: AppStyle.headingOne),
          Gap(6),
          TextFieldWidget(maxLine: 5, hintText: 'What do you wanna do?', txtController: descriptionController,),
          Gap(12),
          Text('Category', style: AppStyle.headingOne),
          Gap(6),
          Row(children: [
            Expanded(child: RadioWidget(categColor: Colors.green, titleRadio: 'WORK', valueInput: 1, onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 1)),
            ),
            Expanded(child: RadioWidget(categColor: Colors.blue, titleRadio: 'STUDY', valueInput: 2, onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 2)),
            ),
            Expanded(child: RadioWidget(categColor: Colors.orange, titleRadio: 'MISC', valueInput: 3, onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 3)),
            ),
          ],),
          // Date & Time Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(titleText: 'Date', valueText: dateProv, iconSelection: CupertinoIcons.calendar, 
              onTap: () async{
                final getValue = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2025));
                if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref 
                      .read(dateProvider.notifier)
                      .update((state) => format.format(getValue));
                }
              },),
              Gap(12),
              DateTimeWidget(titleText: 'Time', valueText: ref.watch(timeProvider), iconSelection: CupertinoIcons.clock, 
              onTap: () async{
                final getTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if(getTime != null){
                  ref.read(timeProvider.notifier).update((state) => getTime.format(context));
                }

              },),
            ],
          ),
          // Button Selection
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: (){

                    final getRadioValue = ref.read(radioProvider);
                    String category = '';

                    switch(getRadioValue){
                      case 1:
                      category = 'Work';
                      break;

                      case 2:
                      category = 'Study';
                      break;

                      case 3:
                      category = 'Misc';
                      break;

                    }

                    ref.read(serviceProvider).AddNewTask(TodoModel(
                      titleTask: titleController.text, 
                      description: descriptionController.text, 
                      category: category, 
                      dateTask: ref.read(dateProvider), 
                      timeTask: ref.read(timeProvider), 
                      isDone: false,
                      )
                    );
                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
              ),
            ],)
        ],
      ),
    );
  }
}

