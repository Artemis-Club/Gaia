
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

import '../../const/colors.dart';
import '../../models/task.dart';
import '../../service/supabaseService.dart';
import '../../service/task_supabase.dart';


class Add_Task extends StatefulWidget {
  final Guid userId;
  const Add_Task(this.userId,{super.key});

  @override
  State<Add_Task> createState() => _Add_TaskState();
}

class _Add_TaskState extends State<Add_Task> {
  final title = TextEditingController();
  final subtitle = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors().backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            name_widgets(),
            SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade200,
            minimumSize: Size(170, 48),
          ),
          onPressed: () async{
             await TaskSupabase().addTask(
                Task(id: Guid.newGuid, name:  title.text, status: false, user_id: widget.userId));
            Navigator.pop(context);
          },
          child: Text('add task'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Container imagess() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: indexx == index ? Colors.green.shade200 : Colors.grey,
                  ),
                ),
                width: 140,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset('images/${index}.png'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget name_widgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'name',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.green.shade200,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding subtite_wedgite() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.green.shade200,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}