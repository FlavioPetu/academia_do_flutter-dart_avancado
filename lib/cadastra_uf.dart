import 'conexao.dart' as conexao;

Future<void> cadastraUf(int id_uf, String nome_uf) async {
  var conn_uf = await conexao.getConnection();
  var result = await conn_uf
      .query('insert estados (id_uf, nome_uf) values (?, ?)', [id_uf, nome_uf]);

  await conn_uf.close();
}
