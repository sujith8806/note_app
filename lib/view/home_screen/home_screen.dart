import 'package:flutter/material.dart';
import 'package:note_app/dummy_db.dart';

final GlobalKey formKey = GlobalKey<FormState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    padding: EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null && value!.isEmpty) {
                                return 'Title cannot be blank';
                              } else {
                                return null;
                              }
                            },
                            controller: titleController,
                            decoration: InputDecoration(
                                hintText: 'Title',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value == null && value!.isEmpty) {
                                return 'Description cannot be blank';
                              } else {
                                return null;
                              }
                            },
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: 'Descrition',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value == null && value!.isEmpty) {
                                return 'Title cannot be blank';
                              } else {
                                return null;
                              }
                            },
                            controller: dateController,
                            decoration: InputDecoration(
                                hintText: 'Date',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))),
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                DummyDb.colorsList.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          DummyDb.colorsList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      DummyDb.noteDataList.add({
                                        'title': titleController.text,
                                        'subTitle': descriptionController.text,
                                        'date': dateController.text
                                      });

                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                  ));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          itemCount: DummyDb.noteDataList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
          itemBuilder: (context, index) => NoteCard(
            title: DummyDb.noteDataList[index]['title'],
            subTitle: DummyDb.noteDataList[index]['subTitle'],
            date: DummyDb.noteDataList[index]['date'],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  NoteCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
  });

  String title;
  String subTitle;
  String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.amber[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.edit, color: Colors.black),
                  SizedBox(width: 10),
                  Icon(Icons.delete, color: Colors.black)
                ],
              )
            ],
          ),
          Text(
            subTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              Text(
                date,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
