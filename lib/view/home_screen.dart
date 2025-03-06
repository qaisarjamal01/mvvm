import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../utils/utils.dart';

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
              child: const Text('Logout',style: TextStyle(fontSize: 17),)),
          const SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context,value,child){
          switch(value.moviesList.status){
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.moviesList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          value.moviesList.data!.movies![index].posterurl.toString(),
                        errorBuilder: (context,error,stack){
                          return const Icon(Icons.error,color: AppColors.iconColor,);
                        },
                        ),
                        title: Text(value.moviesList.data!.movies![index].title.toString()),
                        subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toString()),
                            Icon(Icons.star,color: AppColors.starColor,)
                          ],
                        ),
                      ),
                    );
              });
            default:
              return Container();
          }
        }),
      ),
    );
  }
}