import 'package:contact_buddy/AddContact.dart';
import 'package:contact_buddy/Crud.dart';
import 'package:contact_buddy/EndUser.dart';
import 'package:contact_buddy/UpdateContact.dart';
import 'package:contact_buddy/VuewContact.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<endUser> _endUserList = <endUser>[];
  final _endUseService = crudService();

  getAllUserDetails() async {
    var users = await _endUseService.viewAllContacts();
    _endUserList = <endUser>[];
    users.forEach((user) {
      setState(() {
        var userModel = endUser();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        _endUserList.add(userModel);
      });
    });
    setState(() {
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure Want to Delete Contact?',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.red, // foreground
                      ),
                  onPressed: ()  async{
                    var result=await _endUseService.deleteContacts(userId);
                    if (result != null) {
                      Navigator.pop(context);

                      Alert(context: context, title: "Done", desc: "Contact Deleted.").show();;
                      getAllUserDetails();
                    }
                  },
                  child: const Text('Yes')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.blue, // foreground
                      ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "C o n t a c t     B u d d y",
        ),
        actions: [IconButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const addContact()))
              .then((data) {
            if (data != null) {
              Alert(context: context, title: "Done", desc: "Contact Saved.").show();

              getAllUserDetails();
            }
          });
        },
            icon: Icon(Icons.add_circle)),SizedBox(width: 16,)],
      ),
      body: ListView.builder(
          itemCount: _endUserList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                            user: _endUserList[index],
                          )));
                },
                leading: const Icon(Icons.account_circle),
                title: Text(_endUserList[index].name ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => updateContact(
                                    user: _endUserList[index],
                                  ))).then((data) {
                            if (data != null) {
                              Alert(context: context, title: "Done", desc: "Contact Updated.").show();

                              getAllUserDetails();

                            }
                          })
                          ;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )
                    ),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _endUserList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}



