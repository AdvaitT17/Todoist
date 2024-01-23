import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoist/provider/service_provider.dart';

import '../common/show_model.dart';
import '../widget/card_todo_widget.dart';

class HomePage extends ConsumerWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Image.asset('assets/profile.png'),
        ),
        title: const Text('Hello I\'m', style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
        subtitle: const Text('Advait Thakur', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      actions: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.calendar),),
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.bell),),
        ]),

        )
      ],
     ),
    body:  SingleChildScrollView(
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: prefer_const_constructors
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text('Today\'s Task', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                  // ignore: prefer_const_constructors
                  Text('Saturday, 20 Jan', style: TextStyle(color: Colors.grey),),
                ],
              ),
            ElevatedButton(
             style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD5E8FA),
             ),
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                context: context, 
                builder: (context) => AddNewTaskModel(),
                ),
              child: const Text(
                '+ New Task',
                ),
              ),
              // Card List Task
            ],
          ),
          const Gap(20),
          ListView.builder(
            itemCount: todoData.value?.length ?? 0,
            shrinkWrap: true,
            itemBuilder:(context, index) => 
             CardTodoListWidget(getIndex: index),
            )
        ]),
      )),
    );
  }
}
