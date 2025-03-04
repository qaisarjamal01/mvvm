import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appBarColor,
        actions: [
          InkWell(
              onTap: (){
                userPreference.removeUser().then((value){
                  Navigator.pushNamed(context, RoutesName.logIn);
                });
              },
              child: Text('Logout',style: TextStyle(fontSize: 17),)),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}
