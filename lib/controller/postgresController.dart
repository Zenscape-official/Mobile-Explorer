import 'package:postgres/postgres.dart';

Future operation() async{
  
  var connection= PostgreSQLConnection('167.235.151.252', 5432, 'bdjuno',username: 'user1',password: 'sql1234');

  try{
    await connection.open();
    print('connected');
    List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery("SELECT * FROM block WHERE height = 3",
      // substitutionValues: {
      //   "aEmail": email,
    );
    print(result);
  }
  catch(e){
    print('error');
    print(e.toString());
  }
}