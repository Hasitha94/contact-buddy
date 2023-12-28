import 'package:contact_buddy/Crud.dart';
import 'package:contact_buddy/EndUser.dart';
import 'package:flutter/material.dart';


class updateContact extends StatefulWidget {
  final endUser user;
  const updateContact({Key? key,required this.user}) : super(key: key);

  @override
  State<updateContact> createState() => _updateContactState();
}

class _updateContactState extends State<updateContact> {
  var _userName = TextEditingController();
  var _userContact = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  var _userService=crudService();

  @override
  void initState() {
    setState(() {
      _userName.text=widget.user.name??'';
      _userContact.text=widget.user.contact??'';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C o n t a c t     B u d d y"),
        actions: [TextButton(onPressed: () {
          _userName.text = '';
          _userContact.text = '';
        }, child: Text('Clear',style: TextStyle(color: Colors.white),)),SizedBox(width: 16,)],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Update Contact',
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40.0,
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
                height: 20.0,
              ),
              TextField(
                  controller:_userContact ,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact
                        ? 'fill the contact'
                        : null,
                  )),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.purple,
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
                          _endUser.id=widget.user.id;
                          _endUser.name = _userName.text;
                          _endUser.contact = _userContact.text;
                          var result=await _userService.updateContacts(_endUser);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Contact')),
                  const SizedBox(
                    width: 0.0,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
