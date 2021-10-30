import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';



class Try extends StatelessWidget {


  final String getUserQuery = '''
  query ReadUsers{
                getuserData {
                         username
                         fullname
                }
                getuserPhoto {
                         photo_location
                         creation_date
                }
                getuserFeed{
                         contents
                         photo{
                            photo_id
                            photo_location
                         }
                }
                            
}
''';

  @override
  Widget build(BuildContext context) {
   // checkCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),


      body: Query(
        options: QueryOptions(document: gql(getUserQuery), pollInterval: Duration(seconds: 1)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (result.data == null) {
            return Center(child: Text('User not found.'));
          }
          Map<String,dynamic> userList = result.data!['getuserData'];
          Map<String,dynamic> userList1 = result.data!['getuserPhoto'];
          Map<String,dynamic> userList2 = result.data!['getuserFeed'];
          print(userList2);

          String name= userList['username']!=null?userList['username']:' ';
          String uname=userList['fullname']!=null?userList['fullname']:' ';
          String plocation= userList1['photo_location']!=null?userList1['photo_location']:' ';
          String pdate= userList1['creation_date']!=null?userList1['creation_date']:' ';
          String pcontents= userList2['contents']!=null?userList2['contents']:' ';
          String uphoto = userList2['photo']['photo_id']!=null?userList2['photo']['photo_id']:' ';
          String ulocation = userList2['photo']['photo_location']!=null?userList2['photo']['photo_location']:' ';


          return  Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('Data from neo4j at accounts section: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('username: ' +name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('fullname: '+uname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('Data from firestore at post_service: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('PHOTO: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        new Container(
                          width:60.0,
                          height:60.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    plocation)
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ]
                  ),

                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('creation_date: '+pdate,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('Data from mongodb at feed_service: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('contents: '+pcontents,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('photo_id: '+uphoto,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('fetching data of firestore of postservice',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('from feedservice w/o using firestore: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        Text('PHOTO : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                        ),
                        /*Text(ulocation,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),*/
                        new Container(
                          width:60.0,
                          height:60.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    ulocation)
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ]
                  ),
                ]));
        },
      ),
    );
  }

}

















