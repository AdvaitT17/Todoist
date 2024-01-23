import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoist/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data:(todoData) => Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
           color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12), 
            ),
          ),
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(todoData[getIndex].titleTask),
          subtitle: Text(todoData[getIndex].description),
          trailing: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              activeColor: Colors.blue.shade800,
              shape: const CircleBorder(),
              value: todoData[getIndex].isDone,
              onChanged: (value) => print(value),),
          ),
          ),
          Transform.translate(
            offset: const Offset(0, -12),
            child: Container(child: Column(children: [
             Divider(
              thickness: 1.5, 
              color: Colors.grey.shade200,
              ),
              Row(children: [Text('Today'),
              Gap(12),
              Text(todoData[getIndex].timeTask)
              ],)
            ],),),
          )
        ]),
        ))
      ],),
    ),
    error:(error, stackTrace) => Center(child: Text(stackTrace.toString()),), loading:() => Center(child: CircularProgressIndicator(),),);
  }
}

