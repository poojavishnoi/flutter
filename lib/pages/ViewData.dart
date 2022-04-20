import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/Home.dart';

class ViewData extends StatefulWidget {
  const ViewData({ Key? key, required this.document }) : super(key: key);
  final Map<String, dynamic> document;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String type;
  late String category;
  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document["title"] == null ? "Hey There" : widget.document["title"];
    _titleController = TextEditingController(text: title);
    _descriptionController = TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient( colors:[ 
          Color.fromARGB(255, 76, 97, 87),
            Color.fromARGB(255, 152, 224, 208)
            ]
          ),
         ),
         child: SingleChildScrollView(
          child: 
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [IconButton(
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   icon: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 28,
                  ),
                 ),
                //  IconButton(
                //    onPressed: () {
                //      setState(() {
                //       edit = !edit;
                //      });
                //    },
                //    icon: Icon(
                //     Icons.edit,
                //     color: edit ? Colors.red : Colors.black87,
                //     size: 28,
                //   ),
                //  ),
                 
                 ]
                ),
                  
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Text(
                  edit ? "Editing" : "View",
                  style: TextStyle(
                    fontSize: 33,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("New Todo",
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  label("Task Title"),
                  const SizedBox(
                    height: 20,
                  ),
                  title(),
                  const SizedBox(
                    height: 30,
                  ),
                  label("Task Type"),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      taskSelect("Important", 0xffff6d6e),
                      const SizedBox(
                        width: 20,
                      ),
                      taskSelect("Planned", 0xff2bc8d9),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  label("Description"),
                  const SizedBox(
                    height: 12,
                  ),
                  description(),
                  const SizedBox(
                    height: 25,
                  ),
                  label("Category"),
                  const SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      categorySelect("Food", 0xfffff6d6e),
                      const SizedBox(
                        width: 20,
                      ),
                      categorySelect("Workout", 0xfff29732),
                      const SizedBox(
                        width: 20,
                      ),
                      categorySelect("Work", 0xff6557ff),
                      const SizedBox(
                        width: 20,
                      ),
                      categorySelect("Design", 0xff234ebd),
                      const SizedBox(
                        width: 20,
                      ),
                      categorySelect("Run", 0xff2bc8d9),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                    
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  button(),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              )
            ],
          )
         ),
      ),
    );
  }

  Widget taskSelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: type == label  ?Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8
        ),
    
      ),
    );
  }

  Widget categorySelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: category == label  ?Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8
        ),
    
      ),
    );
  }

  Widget button(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("Todo").add({
          "title": _titleController.text, "description": _descriptionController.text, "category": category, "task": type
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => Home()),
          (route) => false);
        },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:const LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ]
          )
        ),
        child:const Text(
          "Add Todo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),      
      ),
    );
  }

 Widget description(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFDAF1EE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        style:const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines:null,
        decoration:const InputDecoration(
          border: InputBorder.none,
          hintText: "Task Description",
          hintStyle: TextStyle (
            color: Colors.grey, 
            fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20
          )
        ),
        
      ),
    );
  }

  Widget label(String label){
    return Text(
      label,
      style:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.2
      ),
    );
  }

  Widget title(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFDAF1EE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style:const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration:const InputDecoration(
          border:  InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle (
            color: Colors.grey, 
            fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20
          )
        ),
        
      ),
    );
  }
}