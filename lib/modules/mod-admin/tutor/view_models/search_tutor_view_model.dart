

import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/shared_service/user_service.dart';
import 'package:stacked/stacked.dart';

class SearchTutorViewModel extends BaseViewModel{
  final _userService = Modular.get<UserService>();

  List<User> _users = [];
  
  Set<User> _tempList = Set<User>();

  Set<User> get tempList => _tempList;

  void setTempList(users){
    _tempList.addAll(users);
  }

  StreamSubscription _subscription;
  void listenToUsers() {
    setBusy(true);
    
    _subscription = _userService.listenToUsersRealTime().listen((usersData) {
      _tempList = Set<User>();
      List<User> updatedUsers = usersData;
      //  print(updatedUsers.length);
      if (updatedUsers != null && updatedUsers.length > 0) {
        _users = updatedUsers;
        notifyListeners();
      }
      _tempList.addAll(updatedUsers);
      setBusy(false);
    });
    
       
   
  }


 

  Future getAllUsers() async {
    setBusy(true);
    var result = await _userService.getUsersOnceOff();
    setBusy(false);

    if(result is String){
      print(result);
      //await showDialogBox(title : "Error", description : result);
    }
    else{
      _users = result;
      _tempList.addAll(result);
      notifyListeners();
    }
  }

  void searchResults(String query){
    print(_tempList.length);
    _tempList = Set<User>();
    for(User user in _users){
      if(user.email.toLowerCase().contains(query.toLowerCase())){
        _tempList.add(user);
        notifyListeners();
      }
    }
  }

  @override
  void dispose() { 
    _subscription.cancel();
    super.dispose();
  }

}