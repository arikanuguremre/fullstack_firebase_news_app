import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fullstack_firebase_news_app/product/models/news.dart';
import 'package:fullstack_firebase_news_app/product/utility/exceptions/custom_exception.dart';
import 'package:kartal/kartal.dart';
class HomeView   extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

      CollectionReference news =  FirebaseFirestore.instance.collection('news');
     

    final response = news.withConverter(
      fromFirestore:(snapshot,options){
        return const News().fromFireBase(snapshot);

    },toFirestore: (value,options){

        if(value==null) throw FireBaseCustomException('$value is null');
          return value.toJson();
    },
      ).get();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body:FutureBuilder(
        future: response,
        builder:(
         BuildContext context,
         AsyncSnapshot<QuerySnapshot<News?>> snapshot,
         )
         {
          switch (snapshot.connectionState){
           
           
            case ConnectionState.none:
            return const LinearProgressIndicator();
          
            case ConnectionState.waiting:
             return Center(child: const CircularProgressIndicator());
            case ConnectionState.active:
              return Center(child: const CircularProgressIndicator());
            case ConnectionState.done:
                if(snapshot.hasData){
                  final values = 
                  snapshot.data!.docs.map((e)=>e.data()).toList() ?? [];
                  
                  return ListView.builder(
                    itemCount: values.length,
                    itemBuilder:(BuildContext context, int index){
                      return Card(
                        child:Column(
                          children: [
                            Image.network(values[index]?.backgroundImage ?? '',
                            height: context.dynamicHeight(0.1),),
                            Text(values[index]?.title ?? '',
                            style: context.textTheme.labelLarge,),
                          ],
                        ),
                      );
                    },
                   );
              } 
              else{
                Text("Error!");
              }    
             

           return Text("Error");
          }
           
          
        },
      ),
    );
  }
}

