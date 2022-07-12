// import 'package:flutter/material.dart';
// import 'package:pinterest/models/pinterest_data.dart';
//
// class DetailProvider extends ChangeNotifier {
//   final TextEditingController controller = TextEditingController();
//   List<Pinterest> _postsList = [];
//   bool _isLoading = true;
//   int _page = 1;
//
//
//   set postsList(List<Pinterest> value){
//     if(_postsList != value){
//       _postsList = value;
//       notifyListeners();
//     }
//   }
//   set isLoading(bool value){
//     if(_isLoading != value){
//       _isLoading = value;
//       notifyListeners();
//     }
//   }
//   set page(int value){
//     if(_page != value){
//       _page = value;
//       notifyListeners();
//     }
//   }
//
//   List<Pinterest> get postsList => _postsList;
//   bool get isLoading => _isLoading;
//   int get page => _page;
// }
