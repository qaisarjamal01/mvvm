import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

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
          const SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context,value,child){
          switch(value.moviesList.status){
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.moviesList.message.toString());
            case Status.COMPLETED:
              return Text('kjsjf');
            default:
              return Container();
          }
        }),
      ),
    );
  }
}