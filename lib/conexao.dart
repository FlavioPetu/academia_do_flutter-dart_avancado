import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost', port: 3306, user: 'root', db: 'dasafio_avancado_dart');
  return await MySqlConnection.connect(settings);
}
