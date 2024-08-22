
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_list_app_fate_internship/restaurant_model.dart';
import 'package:restaurant_list_app_fate_internship/restaurant_services.dart';

void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

//Fetch / Get Resturant Lists
final restaurantLoadProvider = FutureProvider<List<RestaurantModel>>(
  (ref) async {
    return ref.watch(restaurantProvider).getRestaurants();
  }
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Resturants List'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  var loadedList = [];
  var restaurantList = [];

  @override
  void initState() {
    // load the restaurant lists
    ref.read(restaurantLoadProvider.future).then((value) {
      loadedList = restaurantList = value;
    super.initState();
    });
  }

  void searchResturant(String keyword) {
    List<dynamic> searchList = [];
    if(keyword.isEmpty){
      searchList = loadedList;
    }else {
      searchList = loadedList.where((res) => res.name.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
      restaurantList = searchList;
    });

  }


  @override
  Widget build(BuildContext context) {
    final restaurantData = ref.watch(restaurantLoadProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              autofocus: false,
              onChanged: (value) => searchResturant(value),
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Restaurant Name",
                hintStyle: TextStyle(color: Colors.black),
            )),
          ),
          restaurantData.when(data: (list) {
            return Expanded(child: ListView.builder(
                    itemCount: restaurantList.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(restaurantList[index].name.toString(), style: TextStyle(fontSize: 24,),),
                        subtitle: Text(restaurantList[index].cuisine.toString()),
                      ),
                    ),
                  ));
                  }, 
                    error: ((error, stackTrace) => Text(error.toString())),
                    loading: (() => CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
