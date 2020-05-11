

import 'package:letutor/core/models/tutor.dart';
import 'package:stacked/stacked.dart';

class SearchTutorViewModel extends BaseViewModel{

  List<String> tutors = [
    "luisPete@gmail.com",
    "luisDeiagoe@gmail.com",
    "luisSanteiagoe@gmail.com",
    "luisSanteigazola@gmail.com",
    "santeigazola@gmail.com",
    "deigoBrute@gmail.com",
  ];

  Set<String> tempList = Set<String>();

  void searchResults(String query){
    for(String tutor in tutors){
      if(tutor.startsWith(query)){
        tempList.add(tutor);
        notifyListeners();
      }
    }
  }
}