import 'package:contact_buddy/Crud.dart';
import 'package:contact_buddy/EndUser.dart';
import 'package:flutter/material.dart';

class addContact extends StatefulWidget {
  const addContact({Key? key}) : super(key: key);

  @override
  State<addContact> createState() => _addContact();
}

class _addContact extends State<addContact> {
  var _userName = TextEditingController();
  var _userContact = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  var _userService=crudService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("C o n t a c t     B u d d y",),
        actions: [TextButton(
              onPressed: (){
                _userName.text = '';
                _userContact.text = '';
              },
            child: Text(
              'clear',style: TextStyle(color: Colors.white),

            ),

        ),

          SizedBox(
            width: 15,
          ),

        ],

      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add New Contact',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextField(
                  controller: _userName,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                    _validateName ? 'fill name' : null,
                  )),
              const SizedBox(
                height: 25.0,
              ),
              TextField(
                  controller: _userContact,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact Number',
                    labelText: 'Contact Number',
                    errorText: _validateContact
                        ? 'fill contact number'
                        : null,
                  )),
              const SizedBox(
                height: 25.0,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.purple,
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userName.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContact.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false) {
                          // print("Good Data Can Save");
                          var _endUser = endUser();
                          _endUser.name = _userName.text;
                          _endUser.contact =_userContact .text;
                          var result=await _userService.saveContact(_endUser);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
