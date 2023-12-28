import 'package:contact_buddy/EndUser.dart';
import 'package:contact_buddy/Store.dart';


class crudService
{
  late Repository _repository;
  crudService(){
    _repository = Repository();
  }
  //for save contact
  saveContact(endUser user) async{
    return await _repository.insertData('users', user.userMap());
  }
  //for view all contact
  viewAllContacts() async{
    return await _repository.readData('users');
  }
  //for update contact
  updateContacts(endUser user) async{
    return await _repository.updateData('users', user.userMap());
  }
  //for delete contact
  deleteContacts(userId) async {
    return await _repository.deleteDataById('users', userId);
  }

}