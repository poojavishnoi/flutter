import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_todo_app/pages/AddTodoPage.dart';
import 'package:flutter_todo_app/pages/TodoCard.dart';
import 'package:flutter_todo_app/pages/ViewData.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Stream<QuerySnapshot> _stream = 
    FirebaseFirestore.instance.collection("Todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title:const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight:FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions:const [
          CircleAvatar(
            backgroundImage: AssetImage("profile-pic.png"),
          ),
          SizedBox(
            width: 25,
          )
        ],
        bottom:const PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color:Colors.white,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: "",
            ),

            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => AddTodoPage()),
                          (route) => false);
                    },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigoAccent,
                        Colors.purple,
                      ]
                    )
                  ),
                  child:const Icon(
                  Icons.add,
                  size:32,
                  color:Colors.white,
                ),
                ),
              ),
              label:"",
              ),

            const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size:32,
                color:Colors.white,

              ),
              label:"",
              ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              IconData iconData;
              Color iconColor;
              Map<String, dynamic> document = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              switch (document["category"]){
                case "Work":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                case "Design":
                  iconData = Icons.audiotrack;
                  iconColor = Colors.green;
                  break;
                case "Workout":
                  iconData = Icons.alarm;
                  iconColor = Colors.teal;
                  break;
                case "Food":
                  iconData = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;
                case "Run":
                  iconData = Icons.run_circle;
                  iconColor = Colors.amber;
                  break;
                default:
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                
              }
            return InkWell(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (builder) => ViewData(document: document)));
              },
              child: TodoCard(
                      title: document["title"] ?? "Hey there",
                      check: true,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: "10 AM",
                      iconBgColor: Colors.white,
                    ),
            );
          });
        }
      ),
    );
  }
}
